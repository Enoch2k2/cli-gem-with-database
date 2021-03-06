class ExampleProject::Cli
  def start
    puts "Welcome to the song creater"
    main_menu
  end

  def main_menu
    puts ""
    puts "Type '1' to create a song"
    puts "Type '2' to list out songs"
    puts "Type '3' to exit program"
    puts ""
    user_input = gets.strip.to_i

    if user_input == 1
      create_song
      main_menu
    elsif user_input == 2
      list_songs
      main_menu
    elsif user_input == 3
      puts "Thank you for using the song creater, goodbye!"
      exit
    else
      puts "invalid choice, please try again!"
      main_menu
    end
  end

  def create_song
    puts ""
    puts "Please enter a song name"
    song_name = gets.strip
    puts "Please enter a genre name"
    genre_name = gets.strip
    puts "Please enter an artist name"
    artist_name = gets.strip
    puts "Thank you, creating song..."
    song = ExampleProject::Song.find_or_create({name: song_name, artist_name: artist_name, genre_name: genre_name})
    sleep(1)
    puts "#{song.name} has been successfully created."
  end

  def list_songs
    puts ""
    ExampleProject::Song.all.each.with_index(1) do |song, index|
      puts "#{index}. #{song.name} - artist: #{song.artist_name} - genre: #{song.genre_name}"
    end
  end
end