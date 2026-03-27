
require 'sinatra'
require "sinatra/reloader" if development?

require_relative 'lib/domain/entry'
require_relative 'lib/application/entry_filter'
require_relative 'lib/infrastructure/web_scraper'
require_relative 'lib/infrastructure/usage_repository'

scraper = WebScraper.new
filter_service = EntryFilter.new
repo = UsageRepository.new

get '/' do
  all_entries = scraper.fetch_entries
  
  @filter_type = params[:filter] || 'all'

  case @filter_type
  when 'long_titles'
    @entries = filter_service.filter_long_titles(all_entries)
    repo.save_usage_log('long_titles', @entries.length)
  when 'short_titles'
    @entries = filter_service.filter_short_titles(all_entries)
    repo.save_usage_log('short_titles', @entries.length)
  else
    @entries = all_entries
  end

  erb :index
end