# frozen_string_literal: true

class Station

  include InstancesCounter
  include Validation

  attr_accessor :name
  attr_reader :trains

  validate :name, :presence
  validate :name, :length_min, 5
  validate :name, :length_max, 10

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
    @trains << train if train.is_a?(Train)
  end

  def departure(train)
    @trains.delete(train) if @trains.include?(train)
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def block_trains(&block)
    @trains.each(&block)
  end

end
