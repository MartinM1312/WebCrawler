
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
  start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)

  all_entries = scraper.fetch_entries

  end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)

  execution_time_ms = ((end_time - start_time) * 1000).round
  
  @filter_type = params[:filter] || 'all'

  case @filter_type
  when 'long_titles'
    @entries = filter_service.filter_long_titles(all_entries)
    p @entries
    repo.save_usage_log('long_titles', @entries.length, execution_time_ms)
  when 'short_titles'
    @entries = filter_service.filter_short_titles(all_entries)
    repo.save_usage_log('short_titles', @entries.length, execution_time_ms)
  else
    @entries = all_entries
    repo.save_usage_log('all_entries', @entries.length, execution_time_ms)
  end

  erb :index
end