require 'sqlite3'

class UsageRepository
  def initialize(db_path = "usage_logs.db")
    @db = SQLite3::Database.new(db_path)
    setup_schema
  end

  def save_usage_log(applied_filter, entries_returned, execution_time_ms)
    @db.execute(
      "INSERT INTO usage_logs (timestamp, applied_filter, entries_returned, execution_time_ms) VALUES (?, ?, ?, ?)",
      [Time.now.to_i, applied_filter, entries_returned, execution_time_ms]
    )
  end

  private

  def setup_schema
    @db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS usage_logs (
        id INTEGER PRIMARY KEY,
        timestamp INTEGER,
        applied_filter VARCHAR(50),
        entries_returned INTEGER,
        execution_time_ms INTEGER
      );
    SQL
  end

end