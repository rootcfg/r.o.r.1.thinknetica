class PassengerTrain < Train

  def initialize(name, type = :passenger)
    super(name, type)
  end

  def increase_wagons(wagon)
    super(wagon) if wagon.instance_of?(PassangerWagon)
  end

  def decrease_wagons(wagon)
    super(wagon)
  end
end