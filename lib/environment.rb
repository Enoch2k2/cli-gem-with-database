require 'sqlite3'
require 'pry'

DB = { conn: SQLite3::Database.new('./db/songs.db') }

create_songs = <<-SQL
  CREATE TABLE IF NOT EXISTS songs (
    id INTEGER PRIMARY KEY,
    name TEXT,
    genre_name TEXT,
    artist_name TEXT
  );
SQL

DB[:conn].execute(create_songs)
DB[:conn].results_as_hash = true

require_relative "./example_project/version"
require_relative "./example_project/song"
require_relative "./example_project/cli"