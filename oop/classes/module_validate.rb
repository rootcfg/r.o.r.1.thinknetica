module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(name, *args)
      @validates ||= []
      @validates << {attrib: name, args: args}
    end
  end

  module InstanceMethods

    def validate!
      if self.class.superclass == Object
        self.class.instance_variable_get('@validates').each do |attrib|
          send("validate_#{attrib[:args][0].to_s}", attrib)
        end
      else
        self.class.superclass.instance_variable_get('@validates').each do |attrib|
          send("validate_#{attrib[:args][0].to_s}", attrib)
        end
      end
      true
    end

    def valid?
      validate!
      true
    rescue ArgumentError
      false
    end

    private

    def validate_presence(attributes)
      value = instance_variable_get("@#{attributes[:attrib]}")
      fail ArgumentError if value.nil?
    end

    def validate_format(attributes)
      message='Invalid format'
      value = instance_variable_get("@#{attributes[:attrib]}")
      fail ArgumentError, message unless value =~ attributes[:args][1]
    end

    def validate_type(attributes)
      message='Invalid type'
      value = instance_variable_get("@#{attributes[:attrib]}")
      fail ArgumentError, message unless value.instance_of?(attributes[:attrib].to_s.class)
    end

    def validate_length_min(attributes)
      message="Invalid length. Must be greater than #{attributes[:args][1]}"
      value = instance_variable_get("@#{attributes[:attrib]}")
      fail ArgumentError, message if value.length < attributes[:args][1]
    end

    def validate_length_max(attributes)
      message="Invalid length. Must be lower than #{attributes[:args][1]}"
      value = instance_variable_get("@#{attributes[:attrib]}")
      fail ArgumentError, message if value.length > attributes[:args][1]
    end
  end
end