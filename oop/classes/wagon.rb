# frozen_string_literal: true

class Wagon

  NUMBER_FORMAT = /^.{4,10}|\d{1,3}$/i.freeze

  include Company
  include Validation
  
  attr_accessor :number, :weight, :color
  attr_reader :empty_weight, :max_weight, :max_speed

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

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
end
