require_relative '../../lib/application/entry_filter'
require_relative '../../lib/domain/entry'

RSpec.describe EntryFilter do
  let(:short_title_entry) { 
    Entry.new(rank: 1, title: "Short title here", points: 150, comments: 20)
  }
  let(:long_title_entry_1) { 
    Entry.new(rank: 2, title: "This is a very long title indeed", points: 50, comments: 100) 
  }
  let(:long_title_entry_2) { 
    Entry.new(rank: 3, title: "Another extremely long and interesting title", points: 10, comments: 300) 
  }
  let(:entries) { [short_title_entry, long_title_entry_1, long_title_entry_2] }
  
  subject(:filter) { described_class.new }

  describe '#filter_long_titles' do
    it 'Returns the entries with more than 5 words ordered by comments' do
      result = filter.filter_long_titles(entries)

      expect(result.length).to eq(2)
      
      expect(result.first).to eq(long_title_entry_2)
      expect(result.last).to eq(long_title_entry_1)
    end
  end

  describe '#filter_short_titles' do
    it 'Returns the entries with less than 5 words ordered by points' do

      short_title_entry_2 = Entry.new(rank: 4, title: "Also short", points: 200, comments: 5)
      mixed_entries = entries + [short_title_entry_2]

      result = filter.filter_short_titles(mixed_entries)

      expect(result.length).to eq(2)
      
      expect(result.first).to eq(short_title_entry_2)
      expect(result.last).to eq(short_title_entry)
    end
  end
end