class Song 
  #extend Concerns::Findable
  attr_accessor :name
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name 
    if artist != nil 
      self.artist = artist 
    end
    if genre != nil 
      self.genre = genre 
    end
    save
  end
  
  def save 
    @@all << self 
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    self.all.clear
  end
  
  def self.create(name)
    self.new(name) 
  end
  
  def artist 
    @artist 
  end 
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
   
  def genre  
    @genre 
  end 
  
  def genre=(genre)
    @genre= genre
    genre.add_song(self)
  end
  
  def self.find_by_name(name)
    found_artist = @@all.find{|artist| artist.name == name}
    found_artist
  end
  
  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end
  
  def self.new_from_filename(name)
    artist, song, genre_name = name.split(' - ')
    fixed_name = genre_name.gsub('.mp3','')
    artist = Artist.find_or_create_by_name(artist)
    genre = Genre. find_or_create_by_name(fixed_name)
    new(song, artist, genre)
  end
  
  def self.create_from_filename(name)
    new_from_filename(name).save
  end
end 