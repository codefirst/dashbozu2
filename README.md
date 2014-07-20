Dashbozu
=============================================================
Store and notify your all development activities.

[![Build Status](https://secure.travis-ci.org/codefirst/dashbozu2.png?branch=master)](http://travis-ci.org/codefirst/dashbozu2)
[![Code Climate](https://codeclimate.com/github/codefirst/dashbozu2.png)](https://codeclimate.com/github/codefirst/dashbozu2)

Install
----------------

Install dependencies:

    $ bundle install --path .bundle --without development test

Precompile assets:

    $ bundle exec rake assets:precompile RAILS_ENV=production

Parameters
---------------

Edit config/dashbozu.yml

or set environment variables:

* GITHUB\_KEY
* GITHUB\_SECRET
* BITBUCKET\_KEY
* BITBUCKET\_SECRET

If you do not have GitHub and Bitbucket keys, go to

* https://github.com/settings/applications
* https://bitbucket.org/account/user/YOUR-ACCOUNT/api


For developers
---------------

Install dependencies:

    $ bundle install --path .bundle

Setup DB:

    $ bundle exec rake db:migrate

Run Rails

    $ bundle exec rails s

Run tests:

    $ bundle exec rake

Hooks
---------------

### GitHub

Access to your repository setting page.
Add below URL to "Service Hook".

    http://your.dashbozu.host/hook/your-api-key/github

### Bitbucket

Access to your repository setting page.
Add below URL to "POST" and "Pull Request POST" services.

    http://your.dashbozu.host/hook/your-api-key/bitbucket

### TravisCI

    gem install travis
    travis encrypt http://your.dashbozu.host/hook/your-api-key/travis_ci

You will get encrypted value. Edit ```.travis.yml```.

    ...
    notifications:
      webhooks:
        secure: "your-encrypted-value"

### Heroku

    heroku addons:add deployhooks:http \
      --url=http://your.dashbozu.host/hook/your-api-key/heroku

### New Relic

Access to your New Relic notification setting page.
Set below URL to "WebHook".

    http://your.dashbozu.host/hook/your-api-key/new_relic

### Errbit

Access to App Edit page.
Add WEBHOOK to NOTIFICATION SERVICE, and set below URL to URL.

    http://your.dashbozu.host/hook/your-api-key/errbit

### Wercker

Write `wercker.yml` as following:

    build:
       after-steps:
          - mzp/http-notify:
              url: $DASHBOZU_URL

And set URL as a application environment(we recomend as protected value):

    http://your.dashbozu.host/hook/your-api-key/wercker

### Jenkins

Install 'Notification Plugin' from Jenkins update center.

And set below settings.

* Format: JSON
* Protocol: HTTP
* URL: http://your.dashbozu.host/hook/your-api-key/jenkins

### Sunline

Add hooks to script as following:

    http://your.dashbozu.host/hook/your-api-key/sunline

### Redmine

Install 'Redmine Plugin' from https://github.com/suer/redmine_webhook.

Add post URL in project settings page as following:

    http://your.dashbozu.host/hook/your-api-key/redmine

### dploy.io

Set 'Post-Deployment URL' in 'Servers Configuration':

    http://your.dashbozu.host/hook/your-api-key/dploy

### Hatena Bookmark

Set Web Hook configuration in your preference:

    http://your.dashbozu.host/hook/your-api-key/hatena_bookmark

### Trello

1. Get developer API_KEY. Access: https://trello.com/1/appkey/generate
2. Get TOKEN. Access: https://trello.com/1/authorize?key=API_KEY&name=dashbozu&expiration=never&response_type=token&scope=read
3. Get BOARD_SHORT_ID. Look your board URL: https://trello.com/b/BOARD_SHORT_ID/BOARD_NAME
4. Get BOARD_ID. Access: https://trello.com/1/boards/BOARD_SHORT_ID
3. Create WebHook.

    $ curl -XPOST 'https://trello.com/1/tokens/[TOKEN]/webhooks/?key=API_KEY' -d '{
      "description": 'Dashbozu',
      "callbackURL": 'http://your.dashbozu.host/hook/your-api-key/trello',
      "idModel": 'BOARD_ID'
    }'

Notification
---------------

### AsakusaSatellite

Set below ENV variables.

* OUTPUT_ASAKUSA_SATELLILTE_URL
* OUTPUT_ASAKUSA_SATELLILTE_API_KEY
* OUTPUT_ASAKUSA_SATELLILTE_ROOM_ID
* OUTPUT_ASAKUSA_SATELLILTE_MESSAGE_TEMPLATE


### ChatWork

Set below ENV variables.

* OUTPUT_CHAT_WORK_TOKEN
* OUTPUT_CHAT_WORK_ROOM_ID
* OUTPUT_CHAT_WORK_MESSAGE_TEMPLATE


### Http

Set below ENV variables.

* OUTPUT_HTTP_URL

It posts data as JSON format.
For example:

    {
      "id":34,
      "title":"[Deploy] test - aaaa",
      "body":"new_commit",
      "source":"heroku",
      "project_id":1,
      "url":"http://www.example.com/",
      "icon_url":"https://secure.gravatar.com/avatar/462233d5aedf66a793dcd95f814f8811?secure=true\u0026size=32",
      "status":"error",
      "author":"mallowlabs@gmail.com",
      "created_at":"2014-01-19T14:46:47.476Z",
      "updated_at":"2014-01-19T14:46:47.489Z",
      "encrypted_identifier":"afd6033f1b0ebe47c0152016566e29c26cfeb2d1"
    }

