class PassangerWagon < Wagon

  attr_accessor :number
  attr_reader :seats, :passengers, :type

  def initialize(number, passengers = 36, seats = 36, type = :passenger)
    super(number)
    @all_seats = @seats = seats
    @type = type
    @passengers = passengers
  end

  def take_seat!
    @seats.positive? ? @seats -= 1 : raise('Местов нет')
  end

  def occupies_seats
    @all_seats - @seats
  end

end