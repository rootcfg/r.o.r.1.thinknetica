module Accessor
  def self.included(base)
    base.extend ClassMethods
    base.send(:include, InstanceMethods)
  end

  module ClassMethods

    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name) }
        instance_variable_set("#{var_name}_history".to_sym, [])
        define_method("#{name}=") do |value|
          old_val = instance_variable_get("@#{name}")
          if instance_variable_get("@#{name}_history")
            send("#{name}_history").push(old_val)
          elsif old_val
            instance_variable_set("@#{name}_history", [])
            send("#{name}_history").push(old_val)
          else
            instance_variable_set("@#{name}_history", [])
          end
          instance_variable_set("@#{name}", value)
        end
        define_method(name.to_sym) { instance_variable_get(var_name) }
        define_method("#{name}_history".to_sym) { instance_variable_get("@#{name}_history") }
      end
    end


    def strong_attr_accessor(name, klass)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=") do |value|
        raise 'Class type exception' unless value.is_a?(klass)

        instance_variable_set(var_name, value)
      end
    end
  end
end