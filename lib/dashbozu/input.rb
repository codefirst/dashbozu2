module Dashbozu
  class Input
    def initialize
      super
    end

    def payload
      'payload'
    end

    def hook(project, payload_body)
      []
    end
  end
end
