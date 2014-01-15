module Dashbozu
  class InputBitbucket < Input
    Dashbozu::Plugin.register_input('bitbucket', self)

    def initialize
      super
    end

    def hook(project, params)
      if params[:payload]
        json = MultiJson.load(params[:payload])
        return hook_push(project, json)
      elsif params['pullrequest_created']
        return hook_pullrequest_created(project, params)
      end
      []
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
          url: "#{url}commits/#{c['raw_node']}",
          author: c['author'],
          icon_url: GravatarImageTag.gravatar_url(extract_email(c['raw_author'])),
          source: 'bitbucket'
        )
      end
    end

    def extract_email(raw_author)
      return '' if raw_author.blank?
      extracted = raw_author.scan(/.*<(.*)>/)
      return '' if extracted.empty?
      last = extracted.last
      return '' if last.empty?
      last.last
    end

    def hook_pullrequest_created(project, json)
      pullreq = json['pullrequest_created']
      [Activity.new(
        project_id: project.id,
        title: "[Pull Request] #{pullreq['destination']['repository']['full_name']} - ##{pullreq['id']} created: #{pullreq['title']}",
        body: pullreq['description'],
        url: pullreq['links']['html']['href'],
        author: pullreq['author']['username'],
        icon_url: pullreq['author']['links']['avatar']['href'],
        source: 'bitbucket'
      )]
    end
  end
end
