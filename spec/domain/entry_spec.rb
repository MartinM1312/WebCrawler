require_relative '../../lib/domain/entry'

RSpec.describe Entry do
  describe '#word_count' do
    it 'Counts words on a title with no special characters' do
      entry = Entry.new(rank: 1, title: "A simple title", points: 10, comments: 5)
      expect(entry.word_count).to eq(3)
    end

    it 'Counts words on a title with special characters' do
      entry = Entry.new(rank: 2, title: "This is - a self-explained example", points: 10, comments: 5)
      expect(entry.word_count).to eq(5)
    end

    it 'Empty titles should return 0' do
      entry = Entry.new(rank: 3, title: "", points: 10, comments: 5)
      expect(entry.word_count).to eq(0)
    end
  end
end