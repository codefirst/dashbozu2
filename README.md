Dashbozu: Store and notify your all development activities.
=============================================================

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
* https://bitbucket.org/account/user/<YOUR ACCOUNT>/api


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

