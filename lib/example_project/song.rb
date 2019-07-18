class ExampleProject::Song

  def self.table_name
    self.name.downcase.gsub("exampleproject::", "") + "s"
  end

  def self.column_names
    
    sql = "PRAGMA table_info(#{self.table_name})"

    table_info = DB[:conn].execute(sql)

    columns = table_info.map do |column|
      column["name"]
    end
  end
  
  self.column_names.each do |key|
    attr_accessor key.to_sym
  end

  def initialize(options = {})
    options.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  def column_names_for_insert
    self.class.column_names.reject {|col| col == "id"}.join(", ")
  end

  def values_for_insert
    column_names_for_insert.split(", ").map do |attribute|
      "'#{self.send(attribute)}'"
    end.join(", ")
  end

  def save
    unless self.id

      sql = <<-SQL
        INSERT INTO #{self.class.table_name} (#{column_names_for_insert}) VALUES (#{values_for_insert})
      SQL

      DB[:conn].execute(sql)

      self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs").flatten[0][0]
    end
  end

  def self.create(hash)
    self.new(hash).tap {|obj| obj.save }
  end

  def self.find(hash)
    self.all.find {|obj| obj.name == hash[:name] && obj.artist_name == hash[:artist_name] && obj.genre_name == hash[:genre_name]}
  end

  def self.find_or_create(hash)
    if song = self.find(hash)
      song
    else
      self.create(hash)
    end
  end

  def self.all
    # collect all of the song data
    sql = <<-SQL
      SELECT * FROM songs
    SQL

    data = DB[:conn].execute(sql)
    # iterate through song data, instantiate objects
    data.map do |hash|
      self.new(hash)
    end
    # return array of objects
  end
end