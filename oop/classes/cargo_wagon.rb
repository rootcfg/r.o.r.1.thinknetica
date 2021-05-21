class CargoWagon < Wagon

  attr_accessor :tonnage, :number
  attr_reader :type

  def initialize(number, type =:cargo, tonnage = 10)
    super(number)
    @tonnage = tonnage
    @type = type
  end

end