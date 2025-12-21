use serde_json::Value;
use std::{error::Error, fmt, time::Duration};

const COLOR_TAG: &str = "#6B5A68";
const USER_AGENT: &str = "polybar-weather-rust/1.0";
const WEATHER_ICON: &str = "";
const LATITUDE: &str = env!("LATITUDE");
const LONGITUDE: &str = env!("LONGITUDE");

#[derive(Debug, Clone, Copy)]
struct Weather {
    temperature_celsius: f64,
    wind_meters_per_second: f64,
    rain_probability_next_hour_percent: i64,
}

#[derive(Debug)]
struct JsonShapeError(&'static str);

impl fmt::Display for JsonShapeError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "unexpected Open-Meteo JSON shape: {}", self.0)
    }
}
impl Error for JsonShapeError {}

fn polybar_tag(text: &str) -> String {
    format!("%{{F{}}}{}%{{F-}}", COLOR_TAG, text)
}

fn build_url(latitude: f64, longitude: f64) -> String {
    format!(
        "https://api.open-meteo.com/v1/forecast\
         ?latitude={latitude}&longitude={longitude}\
         &current=temperature_2m,wind_speed_10m\
         &hourly=precipitation_probability\
         &forecast_hours=1\
         &windspeed_unit=ms\
         &timezone=auto"
    )
}

fn extract_weather(json: &Value) -> Result<Weather, Box<dyn Error>> {
    let current = json.get("current").ok_or(JsonShapeError("missing 'current'"))?;
    let hourly = json.get("hourly").ok_or(JsonShapeError("missing 'hourly'"))?;

    let temperature_celsius = current
        .get("temperature_2m")
        .and_then(Value::as_f64)
        .ok_or(JsonShapeError("missing/invalid 'current.temperature_2m'"))?;

    let wind_meters_per_second = current
        .get("wind_speed_10m")
        .and_then(Value::as_f64)
        .ok_or(JsonShapeError("missing/invalid 'current.wind_speed_10m'"))?;

    let rain_probability_next_hour_percent = hourly
        .get("precipitation_probability")
        .and_then(Value::as_array)
        .and_then(|a| a.get(0))
        .and_then(Value::as_i64)
        .ok_or(JsonShapeError(
            "missing/invalid 'hourly.precipitation_probability[0]'",
        ))?
        .clamp(0, 100);

    Ok(Weather {
        temperature_celsius,
        wind_meters_per_second,
        rain_probability_next_hour_percent,
    })
}

fn fetch_weather(latitude: f64, longitude: f64) -> Result<Weather, Box<dyn Error>> {
    let url = build_url(latitude, longitude);

    let body = ureq::get(&url)
        .set("User-Agent", USER_AGENT)
        .timeout(Duration::from_secs(3))
        .call()
        .map_err(|e| format!("http error: {e}"))?
        .into_string()
        .map_err(|e| format!("read body error: {e}"))?;

    let json: Value = serde_json::from_str(&body)?;
    extract_weather(&json)
}

fn format_output(weather: Weather) -> String {
    let temperature_celsius = weather.temperature_celsius.round() as i64;
    let wind_meters_per_second = weather.wind_meters_per_second.round() as i64;
    let rain_probability_next_hour_percent = weather.rain_probability_next_hour_percent;

    format!(
        "{} {}°C {}m/s {}%",
        polybar_tag(WEATHER_ICON),
        temperature_celsius,
        wind_meters_per_second,
        rain_probability_next_hour_percent
    )
}

fn fallback_output() -> String {
    format!("{} open-meteo", polybar_tag("Zzz"))
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
        Err(_) => fallback_output(),
    };
    println!("{output}");
}
