use serde_json::json;
use std::{error::Error, fmt, time::Duration};

const LATITUDE: &str = env!("LATITUDE");
const LONGITUDE: &str = env!("LONGITUDE");

#[derive(Debug, Clone)]
struct DailyForecast {
    date: String,
    temp_max: f64,
    temp_min: f64,
    rain_probability: i64,
    wind_max: f64,
}

#[derive(Debug, Clone)]
struct Weather {
    temperature_celsius: f64,
    wind_meters_per_second: f64,
    rain_probability_next_hour_percent: i64,
    daily_forecasts: Vec<DailyForecast>,
}

#[derive(Debug)]
struct JsonShapeError(&'static str);

impl fmt::Display for JsonShapeError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "unexpected Open-Meteo JSON shape: {}", self.0)
    }
}
impl Error for JsonShapeError {}

fn build_url(latitude: f64, longitude: f64) -> String {
    format!(
        "https://api.open-meteo.com/v1/forecast?\
         latitude={latitude}&longitude={longitude}\
         &current=temperature_2m,wind_speed_10m\
         &hourly=precipitation_probability\
         &daily=temperature_2m_max,temperature_2m_min,precipitation_probability_max,wind_speed_10m_max\
         &forecast_days=7\
         &forecast_hours=1\
         &windspeed_unit=ms\
         &timezone=auto"
    )
}

fn format_date_short(iso_date: &str) -> String {
    let parts: Vec<&str> = iso_date.split('-').collect();
    if parts.len() != 3 {
        return iso_date.get(5..10).unwrap_or(iso_date).to_string();
    }
    
    let year: i32 = parts[0].parse().unwrap_or(2024);
    let month: i32 = parts[1].parse().unwrap_or(1);
    let day: i32 = parts[2].parse().unwrap_or(1);
    
    let t = [0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4];
    let y = if month < 3 { year - 1 } else { year };
    let w = (y + y/4 - y/100 + y/400 + t[(month-1) as usize] + day) % 7;
    
    let dow = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    let dow_index = ((w + 6) % 7) as usize;
    
    format!("{} {:02}.{:02}", dow[dow_index], day, month)
}

fn extract_daily_forecasts(daily: &serde_json::Value) -> Result<Vec<DailyForecast>, Box<dyn Error>> {
    let time = daily
        .get("time")
        .and_then(serde_json::Value::as_array)
        .ok_or(JsonShapeError("missing/invalid 'daily.time'"))?;
    
    let temp_max = daily
        .get("temperature_2m_max")
        .and_then(serde_json::Value::as_array)
        .ok_or(JsonShapeError("missing/invalid 'daily.temperature_2m_max'"))?;
    
    let temp_min = daily
        .get("temperature_2m_min")
        .and_then(serde_json::Value::as_array)
        .ok_or(JsonShapeError("missing/invalid 'daily.temperature_2m_min'"))?;
    
    let precip_prob = daily
        .get("precipitation_probability_max")
        .and_then(serde_json::Value::as_array)
        .ok_or(JsonShapeError("missing/invalid 'daily.precipitation_probability_max'"))?;
    
    let wind_max = daily
        .get("wind_speed_10m_max")
        .and_then(serde_json::Value::as_array)
        .ok_or(JsonShapeError("missing/invalid 'daily.wind_speed_10m_max'"))?;

    let mut forecasts = Vec::with_capacity(7);
    let limit = std::cmp::min(7, time.len());
    
    for i in 0..limit {
        let date = time[i].as_str().unwrap_or("N/A");
        let date_short = format_date_short(date);
        
        let tmax = temp_max.get(i).and_then(serde_json::Value::as_f64).unwrap_or(0.0);
        let tmin = temp_min.get(i).and_then(serde_json::Value::as_f64).unwrap_or(0.0);
        let rain = precip_prob.get(i).and_then(serde_json::Value::as_i64).unwrap_or(0).clamp(0, 100);
        let wind = wind_max.get(i).and_then(serde_json::Value::as_f64).unwrap_or(0.0);

        forecasts.push(DailyForecast {
            date: date_short,
            temp_max: tmax,
            temp_min: tmin,
            rain_probability: rain,
            wind_max: wind,
        });
    }

    Ok(forecasts)
}

fn extract_weather(json: &serde_json::Value) -> Result<Weather, Box<dyn Error>> {
    let current = json.get("current").ok_or(JsonShapeError("missing 'current'"))?;
    let hourly = json.get("hourly").ok_or(JsonShapeError("missing 'hourly'"))?;
    let daily = json.get("daily").ok_or(JsonShapeError("missing 'daily'"))?;

    let temperature_celsius = current
        .get("temperature_2m")
        .and_then(serde_json::Value::as_f64)
        .ok_or(JsonShapeError("missing/invalid 'current.temperature_2m'"))?;

    let wind_meters_per_second = current
        .get("wind_speed_10m")
        .and_then(serde_json::Value::as_f64)
        .ok_or(JsonShapeError("missing/invalid 'current.wind_speed_10m'"))?;

    let rain_probability_next_hour_percent = hourly
        .get("precipitation_probability")
        .and_then(serde_json::Value::as_array)
        .and_then(|a| a.first())
        .and_then(serde_json::Value::as_i64)
        .ok_or(JsonShapeError(
            "missing/invalid 'hourly.precipitation_probability[0]'",
        ))?
        .clamp(0, 100);

    let daily_forecasts = extract_daily_forecasts(daily)?;

    Ok(Weather {
        temperature_celsius,
        wind_meters_per_second,
        rain_probability_next_hour_percent,
        daily_forecasts,
    })
}

fn fetch_weather(latitude: f64, longitude: f64) -> Result<Weather, Box<dyn Error>> {
    let url = build_url(latitude, longitude);

    let body = ureq::get(&url)
        .set("User-Agent", "waybar-weather-rust/1.0")
        .timeout(Duration::from_secs(5))
        .call()
        .map_err(|e| format!("http error: {e}"))?
        .into_string()
        .map_err(|e| format!("read body error: {e}"))?;

    let json: serde_json::Value = serde_json::from_str(&body)?;
    extract_weather(&json)
}

fn format_output(weather: Weather) -> String {
    let temp = weather.temperature_celsius.round() as i64;
    let wind = weather.wind_meters_per_second.round() as i64;
    let rain = weather.rain_probability_next_hour_percent;

    let text = format!(
        "<span color='#888888'></span> {}°  \
         <span color='#888888'></span> {}m/s  \
         <span color='#888888'>󰖖</span> {}%",
        temp, wind, rain
    );

    // Functional approach: map each day to a line, then join with newlines
    let tooltip = weather.daily_forecasts
        .iter()
        .map(|day| {
            let tmax = day.temp_max.round() as i64;
            let tmin = day.temp_min.round() as i64;
            let rain_prob = day.rain_probability;
            let wind_max = day.wind_max.round() as i64;

            format!(
                "{} <span color='#888888'></span> {:2}°/{:2}°  <span color='#888888'></span> {}m/s  <span color='#888888'>󰖖</span> {:2}%",
                day.date, tmax, tmin, wind_max, rain_prob
            )
        })
        .collect::<Vec<_>>()
        .join("\n");

    json!({
        "text": text,
        "tooltip": tooltip
    })
    .to_string()
}

fn fallback_output() -> String {
    json!({
        "text": "",
        "tooltip": ""
    })
    .to_string()
}

fn run() -> Result<String, Box<dyn Error>> {
    let latitude: f64 = LATITUDE.parse()?;
    let longitude: f64 = LONGITUDE.parse()?;

    let weather = fetch_weather(latitude, longitude)?;
    Ok(format_output(weather))
}

fn main() {
    let output = match run() {
        Ok(text) => text,
        Err(e) => {
            eprintln!("Weather fetch error: {}", e);
            fallback_output()
        }
    };
    println!("{}", output);
}
