# frozen_string_literal: true

class Wagon
  include Company

  attr_accessor :number, :weight, :color
  attr_reader :empty_weight, :max_weight, :max_speed

  NUMBER_FORMAT = /^.{4,10}|\d{1,3}$/i.freeze

  def initialize(number)
    @number = number
    validate!
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate!
    errors = []

    errors << 'Number can`t be blank`' if @number.to_s.empty?
    errors << 'Number must be greather than 3' if @number.to_s.length < 3
    errors << 'Number format is incorrect' if @number !~ NUMBER_FORMAT

    raise errors.join('. ') unless errors.empty?
  end
end
