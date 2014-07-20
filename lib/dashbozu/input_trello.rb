module Dashbozu
  class InputTrello < Input
    Dashbozu::Plugin.register_input('trello', self)

    def initialize
      super
    end

    def hook(project, params)
      json = params['hook']

      return [] if json.nil? or json['action'].nil? or json['model'].nil?

      user = json['action']['memberCreator']
      card = json['action']['data']['card']
      [Activity.new(
          project_id: project.id,
          title: "[Card] #{json['model']['name']} - ##{card['idShort']} : #{card['name']}",
          body: json['action']['type'],
          url: json['model']['url'],
          author: user['username'],
          icon_url: "https://trello-avatars.s3.amazonaws.com/#{user['avatarHash']}/30.png",
          source: 'trello'
      )]
    end

  end
end
