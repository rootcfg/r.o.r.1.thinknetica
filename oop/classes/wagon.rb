class Wagon

  include Company

  attr_accessor :number, :weight, :color
  attr_reader :empty_weight, :max_weight, :max_speed

  NUMBER_FORMAT = /^.{4,10}|\d{1,3}$/i

  def initialize(number)
    @number = number
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    raise 'Number can`t be blank' if @number.empty?
    raise 'Number format is incorrect' unless @number =~ NUMBER_FORMAT
  end

end