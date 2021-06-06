module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(attrib, *args)
      @validates ||= {}
      @validates[attrib] = *args
    end
  end

  module InstanceMethods

    def validate!
      self.class.instance_variable_get('@validates').each do |attrib, args|
        send("validate_#{args[0]}", attrib, *args[1, args.size])
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

    def validate_presence(attrib, *args)
      value = instance_variable_get("@#{attrib}")
      puts value
      fail ArgumentError if value.nil?
    end

    def validate_format(attrib, format, message='Invalid format')
      value = instance_variable_get("@#{attrib}")
      fail ArgumentError, message unless value =~ format
    end

    def validate_type(attrib, type, message='Invalid type')
      value = instance_variable_get("@#{attrib}")
      fail ArgumentError, message unless value.instance_of?(type)
    end
  end
end
