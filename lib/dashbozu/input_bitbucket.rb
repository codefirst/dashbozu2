module Dashbozu
  class InputBitbucket < Input
    Dashbozu::Plugin.register_input('bitbucket', self)

    def initialize
      super
    end

    def hook(project, params)
      payload_body = params[:payload]
      json = MultiJson.load(payload_body)
      hook_push(project, json)
    end

    private
    def hook_push(project, json)
      repos_name = json['repository']['name']
      url = "#{json['canon_url']}#{json['repository']['absolute_url']}"
      json['commits'].map do |c|
        Activity.new(
          project_id: project.id,
          title: "[Commit] #{repos_name} - #{c['node'][0..8]}",
          body: c['message'],
          url: url,
          author: c['author'],
          icon_url: GravatarImageTag.gravatar_url(extract_email(c['raw_author'])),
          source: 'bitbucket'
        )
      end
    end

    def extract_email(raw_author)
      extracted = raw_author.scan(/.*<(.*)>/)
      '' if extracted.empty?
      last = extracted.last
      '' if last.empty?
      last.last
    end
  end
end
