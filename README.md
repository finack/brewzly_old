# Brewzly

[![Build Status](https://travis-ci.org/finack/brewzly.png?branch=master)](https://travis-ci.org/finack/brewzly)
[![Code Climate](https://codeclimate.com/github/finack/brewzly.png)](https://codeclimate.com/github/finack/brewzly)

[Tracker](https://www.pivotaltracker.com/s/projects/850499)

# Requirements

To run the specs or fire up the server, be sure you have these:

* Ruby 2.0.0-p353
* PostgreSQL 9.x with superuser 'postgres' with no password (```createuser -s postgres```)
* PhantomJS for JavaScript testing (```brew install phantomjs```)

# Development

### First Time Setup

After cloning, run these commands to install missing gems and prepare the database.

    $ gem install bundler
    $ bundle
    $ rake db:setup db:sample_data

Note, ```rake db:sample_data``` loads a small set of data for development. Check out [db/sample_data.rb](db/sample_data.rb)
for details.

### Running the Specs

To run all ruby and jasmine specs.

    $ rake

### Running the Application Locally

    $ rails server
    $ open http://localhost:3000

### Using Guard

Guard is configured to either tests or servers.

```sh
bundle exec guard # Launches your test suite
bundle exec guard -g server # Launches Rails and Livereload
```

### Using Mailcatcher

    $ gem install mailcatcher
    $ mailcatcher
    $ open http://localhost:1080/

Learn more at [mailcatcher.me](http://mailcatcher.me/). And please don't add mailcatcher to the Gemfile.

# Heroku

Install the Heroku toolbelt if you don't already have it (https://toolbelt.heroku.com/).

## Quick Reference

```sh
heroku open

heroku addons:docs newrelic
heroku addons:docs rollbar

git push heroku staging feature/foo:master
```

## Setting up a new container

```sh
heroku apps:create brewzly-staging

heroku addons:add newrelic:stark
herolu addons:add rollbar:free

heroku config:set RACK_ENV=staging 

heroku git:remote -a brewzly-staging -r staging
git push heroku staging feature/foo:master
heroku run rake db:setup
```

### Environment Variables

Several common features and operational parameters can be set using environment variables. These are all optional.

* ```HOSTNAME``` - Canonical hostname for this application. Other incoming requests will be redirected to this hostname.
* ```PORT``` - Port to listen on (default: 3000).
* ```UNICORN_WORKERS``` - Number of unicorn workers to spawn (default: development 1, otherwisee 3) .
* ```UNICORN_BACKLOG``` - Depth of unicorn backlog (default: 16).

# Considerations

# Credits

Generated with [Raygun](https://github.com/carbonfive/raygun).
