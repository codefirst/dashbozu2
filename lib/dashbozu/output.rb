module Dashbozu
  class Output
    def self.plugin_name
      ''
    end

    def initialize
      super
    end

    def emit(activities)
      super
    end

    def self.config_param(attr_name)
      name = self.plugin_name
      define_method "#{attr_name}" do
        Settings.get("output.#{name}.#{attr_name}")
      end
    end
  end
end
