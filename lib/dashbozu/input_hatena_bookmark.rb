module Dashbozu
  class InputHatenaBookmark < Input
    Dashbozu::Plugin.register_input('hatena_bookmark', self)
    hook_scope :user

    def initialize
      super
    end

    def hook(project, params)
      [Activity.new(
        project_id: project.id,
        title: "[Bookmark] #{params[:status]} - #{params[:title]}",
        body: "#{params[:comment]} #{params[:url]}",
        url: params[:permalink],
        author: params[:username],
        icon_url: "http://cdn1.www.st-hatena.com/users/su/#{params[:username]}/profile.gif",
        source: 'hatena_bookmark'
      )]
    end
  end
end
