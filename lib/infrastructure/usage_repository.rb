require 'sqlite3'

class UsageRepository
  def initialize(db_path = "usage_logs.db")
    @db = SQLite3::Database.new(db_path)
    setup_schema
  end

  def save_usage_log(filter)
    @db.execute(
      "INSERT INTO usage_logs (timestamp, filter_applied, entries_returned) VALUES (?, ?, ?)",
      [Time.now.to_i, filter_applied, entries_returned]
    )
  end

  private

  def setup_schema
    @db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS usage_logs (
        id INTEGER PRIMARY KEY,
        timestamp INTEGER,
        filter_applied VARCHAR(50),
        entries_returned INTEGER
      );
    SQL
  end

end