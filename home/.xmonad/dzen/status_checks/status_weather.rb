require 'open-uri'
require 'nokogiri'

require 'pry'

# NOTE: cache changes every 10 min
time_cache = Time.now.strftime('%H%M')[0..-2]
cached_result = "/tmp/status_weather_#{time_cache}"

unless File.file?(cached_result)
  doc = Nokogiri::HTML(open("https://p.ya.ru/moscow"))
  value = doc.css('.temp-current').text if doc

  if value
    # NOTE: remove old weather
    File.delete(*Dir.glob('/tmp/status_weather*'))
    desc = doc.css('.today-forecast').text.split(',').first.sub('Сейчас ', '')
    value = value.sub('−', '-')

    File.write(cached_result, "#{value}°")
  end
end
