module Dashbozu
  class PluginClass
    attr_reader :input
    attr_reader :output

    def initialize
      @input = {}
      @output = {}
    end

    def register_input(type, klass)
      @input[type] = klass
    end

    def register_output(type, klass)
      @output[type] = klass
    end
  end

  Plugin = PluginClass.new
end
