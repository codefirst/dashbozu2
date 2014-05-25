module Dashbozu
  class InputHatenaBookmark < Input
    Dashbozu::Plugin.register_input('hatena_bookmark', self)

    def initialize
      super
    end

    def self.scope
      :user
    end

    def hook(project, params)
      [Activity.new(
        project_id: project.id,
        title: "[Bookmark] #{params[:status]} - #{params[:title]}",
        body: "#{params[:comment]} #{params[:url]}",
        url: params[:permalink],
        author: params[:username],
        icon_url: '',
        source: 'hatena_bookmark'
      )]
    end
  end
end
