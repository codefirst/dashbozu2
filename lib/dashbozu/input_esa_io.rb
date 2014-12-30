module Dashbozu
  class InputEsaIo < Input
    Dashbozu::Plugin.register_input('esa_io', self)

    def initialize
      super
    end

    def hook(project, params)
      json = params

      post = json['post']
      user = json['user']

      return [] if json.nil? or post.nil? or user.nil?

      body = post['body_md']
      case json['kind']
      when 'post_create'
        kind = 'create'
      when 'post_update'
        kind = 'update'
      when 'post_archive'
        kind = 'archive'
      when 'comment_create'
        kind = 'comment'
        body = json['comment']['body_md']
      else
        return []
      end

      [Activity.new(
        project_id: project.id,
        title: "[Document] #{kind}: #{post['name']}",
        body: body,
        url: post['url'],
        author: user['screen_name'],
        icon_url: user['icon']['thumb_s']['url'],
        source: 'esa_io'
      )]
    end
  end
end
