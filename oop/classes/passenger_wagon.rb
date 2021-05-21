class PassangerWagon < Wagon

  attr_accessor :number
  attr_reader :seats, :passengers, :type

  def initialize(number, passengers = 36, seats = 36, type = :passenger)
    super(number)
    @seats = seats
    @type = type
    @passengers = passengers
  end

end