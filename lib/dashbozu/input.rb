module Dashbozu
  class Input
    def initialize
      super
    end

    def self.scope
      @scope || :project
    end

    def self.hook_scope(scope)
      @scope = scope
    end

    def hook(project, params)
      []
    end
  end
end
