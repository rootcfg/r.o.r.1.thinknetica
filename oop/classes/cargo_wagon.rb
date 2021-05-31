class CargoWagon < Wagon

  attr_accessor :number
  attr_reader :type, :max_tonnage

  def initialize(number, type = :platform, tonnage)
    super(number)
    @max_tonnage = @tonnage = tonnage
    @type = type
  end

  def available_tonnage
    if @max_tonnage != @tonnage
       @max_tonnage - @tonnage
    else
       @tonnage
    end
  end

  def occupied_tonnage
    @tonnage
  end

  def decrise_tonnage(val)
    tonnage = @tonnage.positive? ? @tonnage -= val : raise('Can`t decrise tonnage!')
  end

end