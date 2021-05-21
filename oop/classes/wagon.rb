class Wagon

  attr_accessor :number, :weight, :color
  attr_reader :empty_weight, :max_weight, :max_speed

    def initialize(number)
    @number = number
  end

end