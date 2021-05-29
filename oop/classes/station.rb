class Station

  include InstancesCounter

  attr_accessor :name
  attr_reader :trains

  @@all_stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << self
    validate!
    register_instance
  end

  def self.all
    @@all_stations
  end

  def arrival(train)
    @trains << train if train.instance_of?(Train)
  end

  def departure(train)
    @trains.delete(train) if @trains.include?(train)
  end

  def trains_by_type(type)
    @trains.select {|train| train.type == type }
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    raise "Name can't be blank" if @name.empty?
    raise 'Name too short! Please fiil more than 1 symbols.' if @name.length <= 2
  end

end