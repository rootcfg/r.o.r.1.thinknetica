# frozen_string_literal: true

class CargoTrain < Train
  attr_reader :max_tonnage

  def initialize(name, type = :platform)
    super(name, type)
    @max_tonnage = max_tonnage
  end

  def increase_wagons(wagon)
    super(wagon) if wagon.instance_of?(CargoWagon)
  end
end
