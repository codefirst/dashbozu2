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

