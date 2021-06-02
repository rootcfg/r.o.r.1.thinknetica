# frozen_string_literal: true

class PassengerTrain < Train
  def initialize(name, type = :passenger)
    super(name, type)
  end

  def increase_wagons(wagon)
    super(wagon) if wagon.instance_of?(PassangerWagon)
  end
end
