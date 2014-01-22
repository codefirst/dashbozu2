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
        secure: "your-encrepted-value"

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
* URL:http: //your.dashbozu.host/hook/your-api-key/jenkins

### Sunline

Add hooks to script as following:

    http://your.dashbozu.host/hook/your-api-key/sunline

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

