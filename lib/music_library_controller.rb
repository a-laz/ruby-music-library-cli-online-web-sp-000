require 'pry'
class MusicLibraryController
  def initialize(path="./db/mp3s")
    @path = path
    MusicImporter.new(path).import
  end
  def call
    input = ""
    while input != "exit"

      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.strip

      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end
    end
  end

  def list_songs
    Song.all.sort { |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
      puts "#{i}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
    end
  end

  def list_artists
    Artist.all.sort{ |a,b| a.name <=> b.name }.each.with_index(1) do |a, i|
      puts "#{i}. #{a.name}"
    end
  end

  def list_genres
    Genre.all.sort{ |a,b| a.name <=> b.name }.each.with_index(1) do |g, i|
      puts "#{i}. #{g.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name = gets.strip
    artist = Artist.find_or_create_by_name(artist_name)
    artist.songs.sort{|a,b| a.name <=> b.name}.each.with_index(1) do |s, i|
      puts "#{i}. #{s.name} - #{s.genre.name}"
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_name = gets.strip
    genre = Genre.find_or_create_by_name(genre_name)
    genre.songs.sort{|a,b| a.name <=> b.name}.each.with_index(1) do |s, i|
      puts "#{i}. #{s.artist.name} - #{s.name}"
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    songs_list = Song.all.sort { |a, b| a.name <=> b.name }
    song_number_index = gets.strip.to_i - 1
    song = songs_list[song_number_index]
    number_of_songs = songs_list.length
    if song && song_number_index.between?(1, number_of_songs)
      puts "Playing #{song.name} by #{song.artist.name}"
    end
    #binding.pry
  end
end
