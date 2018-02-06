# Cortex CMS [![Build Status](https://semaphoreci.com/api/v1/projects/ec90715a-da8f-4960-bb64-f371850f9c98/813409/shields_badge.svg)](https://semaphoreci.com/content-enablement/cortex) [![Code Climate](https://codeclimate.com/repos/53f62c2869568018180036c9/badges/78e3c3c865b118bbd72b/gpa.svg)](https://codeclimate.com/repos/53f62c2869568018180036c9/feed) [![Test Coverage](https://codeclimate.com/repos/53f62c2869568018180036c9/badges/78e3c3c865b118bbd72b/coverage.svg)](https://codeclimate.com/repos/53f62c2869568018180036c9/coverage) [![Documentation Status](https://www.gitbook.com/button/status/book/cortex-cms/cortex-cms)](https://docs.cortexcms.org/)
<img align="right" height="150"
     src="https://hiring-assets.careerbuilder.com/branding/cortex-logo.svg"
     alt="Cortex CMS Logo">

Cortex CMS is a [multitenant](https://en.wikipedia.org/wiki/Multitenancy) identity, content distribution/management and reporting platform built by the [Content Enablement][cb-ce-github] team at [CareerBuilder](https://github.com/careerbuilder). Its purpose is to provide central infrastructure for next-generation applications; exposing a single point of management while enabling quicker build-out of new software.

Cortex follows a decentralized, API-only architecture - it is *not* built like Wordpress or Drupal, which are considered monolithic, all-in-one solutions.

## Table of Contents

- [Setup](#setup)
  - [Environment](#environment)
  - [Dependencies](#dependencies)
    - [System](#system)
      - [OS X](#os-x)
      - [Linux](#linux)
    - [Application](#application)
  - [Database](#database)
  - [Server](#server)
  - [Deployment](#deployment)
- [Running Test Suite](#running-test-suite)
- [API](#api)
  - [Documentation](#documentation)
- [Consuming Cortex](#consuming-cortex)
  - [Authorization](#authorization)
  - [Content](#content)
  - [Localizations](#localizations)
  - [Exceptions](#exceptions)
- [Applications Using Cortex](#applications-using-cortex)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)
- [Copyright](#copyright)

## Setup

### Environment

Copy and rename the example `.env.example` file as `.env` and modify it to match your environment.

For a rudimentary setup, these variables should be configured:

* Execute `$ bundle exec rails secret` twice to generate both an `APP_SECRET` and `DEVISE_SECRET`
* If the superuser isn't used for the app databases, the `DATABASE_USERNAME` and `DATABASE_PASSWORD` should be set accordingly.

### Dependencies

#### System

##### OS X

* Install the Xcode Command Line tools:

```sh
$ xcode-select --install
```

* Install all Cortex system-wide dependencies (and the `readline` Ruby/`byebug` build dependency) using [Homebrew](http://brew.sh/) from the `Brewfile` via `$ brew install $(cat Brewfile|grep -v "#")`
* Install Ruby via [rbenv](https://github.com/sstephenson/rbenv) or [rvm](https://rvm.io/).
* Enable system agents:

```sh
$ ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
$ ln -sfv /usr/local/opt/elasticsearch/*.plist ~/Library/LaunchAgents
$ ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents
```

and start them with `brew services`:

```sh
$ brew services start postgresql
$ brew services start elasticsearch
$ brew services start redis
```

or `launchctl`:

```sh
$ launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
$ launchctl load ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist
$ launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist
```

##### Linux

* Install all Cortex system-wide dependencies (and the `readline` Ruby/`byebug` build dependency) using your distribution's package manager (`pacman`, `apt-get`, `yum`, etc). For example, with Ubuntu's `apt-get`:

```sh
$ apt-get install libreadline6-dev postgresql postgresql-contrib redis-server openjdk-8-jre imagemagick jpegoptim ghostscript
```

Ubuntu and Redhat/Fedora do not have an official `elasticsearch` package - you must use Elasticsearch's [repository](https://www.elastic.co/blog/apt-and-yum-repositories) or follow these [instructions](https://github.com/elastic/elasticsearch#installation). The same goes for `phantomjs`. Build from [source](http://phantomjs.org/download.html) or use a [PPA](https://launchpad.net/ubuntu/+ppas?name_filter=phantomjs). Other Linux distributions likely have these as prebuilt packages in their official or user repositories.

* Install Ruby via [rbenv](https://github.com/sstephenson/rbenv) or [rvm](https://rvm.io/).
* Enable system agents using your distribution's service manager frontend, which is likely `systemd`'s frontend, `systemctl`:

```sh
$ systemctl enable postgresql
$ systemctl enable elasticsearch
$ systemctl enable redis
```

and start them with `systemctl`:

```sh
$ systemctl start postgresql
$ systemctl start elasticsearch
$ systemctl start redis
```

#### Application

* Install Bundler and its dependencies:

```sh
$ gem install bundler && bundle install
```

* Install `node`, then run Yarn to install frontend dependencies:

```sh
$ yarn install
```

### Database

* Create databases:

```sh
$ bundle exec rake db:create
```

* Initialize the schema:

```sh
$ bundle exec rake db:schema:load
```

* Seed database with a top-level tenant, the superuser and Custom Content data, then rebuild the ElasticSearch index:

```sh
$ bundle exec rake db:seed
$ bundle exec rake cortex:core:db:reseed
$ bundle exec rake cortex:rebuild_indexes
```

### Server

Start Cortex, Sidekiq and live rebuild/reload via Foreman:

```sh
$ gem install foreman
$ foreman start -f Procfile.dev-server
```

The admin interface should now be accessible locally on port `3000`. To access Cortex as superadmin, login as `admin@cortexcms.org` with password `welcome1`.

### Deployment

Deploying the `development` environment as a non-local server will require an additional environmental variable be set:

```shell
DEPLOYED=true
```

This will configure various things to behave normally in a deployed scenario.

## Running Test Suite

Initialize the test database:

```sh
$ RAILS_ENV=test bundle exec rake db:schema:load db:seed cortex:core:db:reseed
$ RAILS_ENV=test bundle exec rake cortex:rebuild_indexes
```

To run Ruby and JS specs, utilize:

```sh
$ RAILS_ENV=test bundle exec rake spec
$ RAILS_ENV=test bundle exec rake spec:javascript
```

## API

### Documentation

Cortex's live API documentation is available via Swagger. This contains specific endpoints, parameters, and response models.

SwaggerUI is provided at [http://docs.api.cbcortex.com/](http://docs.api.cbcortex.com).

Swagger Endpoints are available at [http://api.cbcortex.com/api/v1/swagger_doc.json](http://api.cbcortex.com/api/v1/swagger_doc.json).

## Consuming Cortex

### Authorization

Cortex's API utilizes [OAuth2](https://tools.ietf.org/html/rfc6749) for Authentication and Authorization. Client Credentials and Authorization Code [grant types](http://alexbilbie.com/2013/02/a-guide-to-oauth-2-grants/) are supported. Want to get up and running quickly with OAuth? Use Cortex's [Ruby client](https://github.com/cortex-cms/cortex-client-ruby) or [OmniAuth strategy](https://github.com/cb-talent-development/omniauth-cortex) for Client Credentials and Authorization Code grants, respectively.

Before an application can consume any data, OAuth credentials must be created for the consuming application in the 'Applications' section of the Cortex admin interface.

### Content

Content can be consumed from a feed or via the resource's endpoint directly. Use the [cortex-client](https://github.com/cbdr/cortex-client) gem to easily consume any content resource and use it in your application.

### Localizations

Localizations can be consumed via the client or via [i18n-backend-cortex](https://github.com/cortex-cms/i18n-backend-cortex), which allows easy localization for Rails applications.

### Exceptions

If a consuming or companion application would like to produce Cortex-equivalent exceptions, use the [cortex-exceptions](https://github.com/cb-talent-development/cortex-exceptions) gem.

## Applications Using Cortex

* [Advice and Resources](https://github.com/cbdr/consumer-main/) - Simple Jobseeker Resources platform built atop the Consumer Web site utilizing Legacy Cortex Posts and Rails. Content will eventually be dynamically dispersed across site (result pages, description pages, etc) [Live Site](https://www.careerbuilder.com/advice)
* [Employer](https://github.com/cbdr/employer) - Redesigned Employer Marketing platform utilizing Legacy Cortex Webpages/Snippets and Rails. [Live Site](https://hiring.careerbuilder.com/)
* [CB1 Lander Shell](https://github.com/cbdr/cb1-lander-shell) - Platform for hosting lander pages and experiments, utilizing Legacy Cortex Posts and Sinatra. [Live Site](http://corporate.careerbuilder.com/)
* [CareerBuilder.com](https://github.com/cbdr/consumer-main) - The main Consumer Web site for CB.com uses Legacy Cortex Posts for the [Privacy](https://www.careerbuilder.com/privacy) and [Terms of Service](https://www.careerbuilder.com/terms) pages.

## Troubleshooting
* For OS X / homebrew users: Run `which node` to ensure node is properly linked. The path shown should match homebrew's default installation path (run `which brew` to reveal this). If its not, then run `brew link node` and follow the instructions.

## Contributing

Anyone and everyone is encouraged to fork Cortex and submit pull requests, propose new features and create issues.

Review [CONTRIBUTING](CONTRIBUTING.md) for complete instructions before you submit a pull request or feature proposal.

## License

Cortex utilizes the Apache 2.0 License. See [LICENSE](LICENSE.md) for details.

## Copyright

Copyright (c) 2018 CareerBuilder, LLC.

[cb-ce-github]: https://github.com/cb-talent-development "Content Enablement on GitHub"
