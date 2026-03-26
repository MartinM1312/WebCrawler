class EntryFilter
  def filter_long_titles(entries)
    entries.select { |entry| entry.word_count > 5 }.sort_by { |entry| -entry.comments }
  end

  def filter_short_titles(entries)
    entries.select { |entry| entry.word_count <= 5 }.sort_by { |entry| -entry.points }
  end
end