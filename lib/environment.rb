require 'sqlite3'
require 'pry'
require 'active_record'
require 'sinatra/activerecord'

# DB = { conn: SQLite3::Database.new('./db/songs.db') }

# create_songs = <<-SQL
#   CREATE TABLE IF NOT EXISTS songs (
#     id INTEGER PRIMARY KEY,
#     name TEXT,
#     genre_name TEXT,
#     artist_name TEXT
#   );
# SQL

# DB[:conn].execute(create_songs)
# DB[:conn].results_as_hash = true

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/development.sqlite"
)

require_relative "./example_project/version"
require_relative "./example_project/song"
require_relative "./example_project/artist"
require_relative "./example_project/genre"
require_relative "./example_project/cli"