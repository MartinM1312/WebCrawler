class Entry
  attr_reader :rank, :title, :points, :comments

  def initialize(rank:, title:, points:, comments:)
    @rank = rank
    @title = title
    @points = points
    @comments = comments
  end

  def word_count
    @title.split.count { |word| word.match?(/[a-zA-Z0-9]/) }
  end
end