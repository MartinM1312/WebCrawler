require 'nokogiri'
require 'open-uri'

class WebScrapper
  def initialize
    base_url = 'https://news.ycombinator.com/'
    
    html_content = URI.open(base_url)

    doc = Nokogiri::HTML(html_content)

    entries = doc.css('.athing')

    p '******* Entries ************'
    p entries.count
  end
end

scrape = WebScrapper.new