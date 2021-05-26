class Station

  include InstancesCounter

  attr_accessor :name
  attr_reader :trains

  @@all_stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@all_station << self
    new_instance
  end

  def self.all_stations
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

end