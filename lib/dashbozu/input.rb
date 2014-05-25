module Dashbozu
  class Input
    def initialize
      super
    end

    def self.scope
      raise "#{self} must override self.scope method"
    end

    def hook(project, params)
      []
    end
  end
end
