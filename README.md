Dashbozu: Store and notify your all development activities.
=============================================================

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

