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

    %w(project user).each do |scope|
      define_method "#{scope}_input" do
        @input.select {|_, plugin| plugin.scope.to_s == scope}
      end
    end
  end

  Plugin = PluginClass.new
end
