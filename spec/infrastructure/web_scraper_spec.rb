require_relative '../../lib/infrastructure/web_scraper'

RSpec.describe WebScraper do
  describe '#fetch_top_entries' do
    let(:scraper) { described_class.new }
    
    let(:local_html_file) { File.open('spec/fixtures/sample.html') }

    before do
      allow(URI).to receive(:open)
        .with('https://news.ycombinator.com/')
        .and_return(local_html_file)
    end

    it 'Gets the right amount of entries' do
      entries = scraper.fetch_entries
    
      expect(entries.length).to eq(30)
    end

    it 'Parses the entries data correctly' do
      entries = scraper.fetch_entries
      first_entry = entries.first

      expect(first_entry.rank).to eq(1)
      expect(first_entry.title).to eq("Show HN: I put an AI agent on a $7/month VPS with IRC as its transport layer (georgelarson.me)")
      expect(first_entry.points).to eq(136)
      expect(first_entry.comments).to eq(53)
    end
    
    it 'Manage entries without comments' do
      entries = scraper.fetch_entries
      
      entry_without_comments = entries.find { |e| e.rank == 27 }
      
      expect(entry_without_comments.title).to eq("Generators in Lone Lisp (matheusmoreira.com)")
      expect(entry_without_comments.comments).to eq(0)
    end
  end
end