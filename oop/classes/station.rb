class Station

  attr_accessor :name
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
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