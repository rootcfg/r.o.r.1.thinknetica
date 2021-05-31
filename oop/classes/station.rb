class Station

  include InstancesCounter
  
  attr_accessor :name
  attr_reader :trains

  @@all_stations = []

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@all_stations << self
    register_instance
  end

  def self.all
    @@all_stations
  end

  def arrival(train)
    @trains << train if train.kind_of?(Train)
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

  def block_trains
    @trains.each { |train| yield(train) }
  end

  private
  
  def validate!
    errors = []

    errors << "Название  не может быть пустым" if @name.length.zero?
    errors << "Название  должно иметь минимум 5 символов" if @name.length < 5
    
    raise errors.join(". ") if !errors.empty?
  end

end