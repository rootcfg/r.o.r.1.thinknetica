module InstancesCounter

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def instances
      @instances
    end

    def instance_increase
      @instances ||= 0
      @instances += 1
    end
  end

  module InstanceMethods
    private

    def new_instance
      self.class.instance_increase
    end
  end
end