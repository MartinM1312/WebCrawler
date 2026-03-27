require 'nokogiri'
require 'open-uri'
require_relative '../domain/entry'
class WebScrapper
  def initialize(url = 'https://news.ycombinator.com/' )
    @url = url
  end

  def fetch_entries
    html_content = URI.open(@url)

    doc = Nokogiri::HTML(html_content)

    entries = []

    doc.css('.athing').each do |entry| 
      rank = entry.css('.rank').text.to_i
      title = entry.css('.titleline').text

      entry_subtext = entry.next_element
      score = entry_subtext.css('.score').text.to_i
      comments = entry_subtext.element_children.text.split('|').last.strip.to_i

      entries << Entry.new(rank: rank, title: title, points: score, comments: comments)
    end

    entries
    
  end

end