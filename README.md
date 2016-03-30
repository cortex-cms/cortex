# Cortex

[![Build Status](https://magnum.travis-ci.com/cbdr/cortex.svg?token=sAtZ4frpstZnGHoeyxTz&branch=master)](https://magnum.travis-ci.com/cbdr/cortex)
[![Code Climate](https://codeclimate.com/repos/53f62c2869568018180036c9/badges/78e3c3c865b118bbd72b/gpa.svg)](https://codeclimate.com/repos/53f62c2869568018180036c9/feed)

## Table of Contents

- [What is Cortex?](#what-is-cortex)
- [Setup](#setup)
  - [Environment](#environment)
  - [Dependencies](#dependencies)
    - [System](#system)
      - [OS X](#os-x)
      - [Linux](#linux)
    - [Application](#application)
  - [Database](#database)
  - [Server](#server)
- [Running Test Suite](#running-test-suite)
- [API](#api)
  - [Tenants](#tenants)
  - [Users](#users)
  - [Media](#media)
  - [Posts](#posts)
  - [Categories](#categories)
  - [Occupations](#occupations)
  - [Localizations](#localizations)
  - [Applications](#applications)
  - [Bulk Jobs](#bulk_jobs)
  - [Documents](#documents)
  - [Snippets](#snippets)
  - [Webpages](#webpages)
- [Consuming Cortex](#consuming-cortex)
  - [Content](#content)
  - [Localizations](#localizations)
  - [Webpages and Snippets](#webpages-and-snippets)
  - [Exceptions](#exceptions)
- [Applications Using Cortex](#applications-using-cortex)
- [Contributing](#contributing)
- [License](#license)
- [Copyright](#copyright)

## What is Cortex?

Cortex is a [multitenant](https://en.wikipedia.org/wiki/Multitenancy) identity, content distribution/management and reporting platform built by the [Content Enablement][cb-ce-github] team at [CareerBuilder](https://github.com/careerbuilder). Its purpose is to provide central infrastructure for next-generation applications; exposing a single point of management while enabling quicker build-out of new software.

Cortex follows a decentralized, API-only architecture - it is *not* built like Wordpress or Drupal, which are considered monolithic, all-in-one solutions.

## Setup

### Environment

Copy and rename the example `.env.example` file as `.env` and modify it to match your environment.

For a rudimentary setup, these variables should be configured:

* Use `$ rake secret` to generate `APP_SECRET` and `DEVISE_SECRET`
* Use `$ pwd` inside your cloned app directory to generate `APP_PATH`. Unicorn's config uses this as its working directory.
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

* Install Bower and use `bower-rails`'s rake task to install dependencies:

```sh
$ npm install -g bower && bundle exec rake bower:install:development
```

### Database

* Create databases:

```sh
bundle exec rake db:create:all
```

* Initialize the schema:

```sh
$ bundle exec rake db:schema:load
```

* Seed database with a top-level tenant, the superuser, Advice & Resources categories, and ONET occupation/industry codes:

```sh
$ bundle exec rake db:seed
$ bundle exec rake cortex:create_categories
$ bundle exec rake cortex:onet:fetch_and_provision
```

### Server

Start Cortex and Sidekiq:

```sh
$ bundle exec rails s
$ bundle exec sidekiq -q default -q mailers
```

The admin interface should now be accessible locally on port `3000`. To access Cortex as superadmin, login as `surgeon@cbcortex.com` with password `welcome1`.

## Running Test Suite

Initialize the test database:

```sh
$ bundle exec rake db:schema:load db:seed cortex:create_categories cortex:onet:fetch_and_provision
```

To run Ruby and JS specs, utilize:

```sh
$ bundle exec rake spec
$ bundle exec rake spec:javascript
```

## API

### Swagger

Cortex's live API documentation is available via Swagger. This contains specific endpoints, parameters, and response models.

SwaggerUI is provided at [http://docs.api.cbcortex.com/](http://docs.api.cbcortex.com).

Swagger Endpoints are available at [http://api.cbcortex.com/api/v1/swagger_doc.json](http://api.cbcortex.com/api/v1/swagger_doc.json).

### Authorization

Cortex's API utilizes OAuth2 for Authentication and Authorization. All grant types are supported. Want to get up and running quickly with OAuth? Use Cortex's [OmniAuth strategy](https://github.com/cb-talent-development/omniauth-cortex).

Review the API resource classes in `app/api/v1/resources` to determine the available scopes.

### Resources

Note: most resources are treated as 'paranoid' - that is, data is never truly deleted in the system - only archived.

#### [Tenants](http://docs.api.cbcortex.com/#!/tenants)

Tenants act as a nested set and are the foundation of the channel-focused content distribution mechanism of Cortex, and allow data to be segregated throughout the system. Tenancy is currently very limited in scope. For example, users are directly tied to a tenant, and content can only be associated with a tenant via an inflexible `content -> user -> tenant` relationship. This will be expanded soon.

#### [Users](http://docs.api.cbcortex.com/#!/users)

Users are for authorization and authentication. They currently lack roles, except for the ability to enable/disable admin access.

#### [Media](http://docs.api.cbcortex.com/#!/media)

Media covers any potential file-type to be stored in or linked to by the Cortex. This includes:

* Images
* Audio
* Video
* Youtube Links
* Documents
* Text

When Media is consumed anywhere within the system, the two pieces of content become tied, and the Media cannot be deleted without the reference removed in the consuming piece of content.

#### [Posts](http://docs.api.cbcortex.com/#!/posts)

Posts serve as a packaged distribution medium consisting of other content. They can be categorized, assigned to an occupation, and contain media of any format.

The posts endpoint also includes other posts-specific functionality, such as post filters and post tags.

#### [Categories](http://docs.api.cbcortex.com/#!/categories)

Categories act as a nested set, living in a tree-like structure with parents and children. Cortex's API provides both this hierarchy and a flat list of categories, with a minimum depth as an optional parameter. These are currently unable to be manipulated via the admin interface, only directly within the database.

#### [Occupations](http://docs.api.cbcortex.com/#!/occupations)

Occupations act as a nested set of Industries with specific Occupations (with SOC codes) beneath them. They utilize the ONET database, and are intended to eventually power intelligent content recommendations. See the `cortex:onet` rake task for specifics.

#### [Localizations](http://docs.api.cbcortex.com/#!/localizations)

Localizations/locales provide YAML/JSON-formatted translations for consuming applications.

#### [Applications](http://docs.api.cbcortex.com/#!/applications)

Applications contain credentials for OAuth applications that consume Cortex.

#### [Bulk Jobs](http://docs.api.cbcortex.com/#!/bulk_jobs)

Bulk Jobs is the generic interface for uploads processed in bulk for any compatible resource, i.e. `users`, `posts` and `media`.

#### [Documents](http://docs.api.cbcortex.com/#!/documents)

Documents are an incredibly generic piece of content, consisting only of raw text. They are intended to be made more specific by other resources, i.e. `snippets` and `webpages`.

#### [Snippets](http://docs.api.cbcortex.com/#!/snippets)

Snippets build ontop of a generic Document, and are intended to be HTML sections on a webpage.

#### [Webpages](http://docs.api.cbcortex.com/#!/webpages)

Webpages group together `snippets`, and correspond to a destination URL, and contain various additional metadata to power a dynamic, editable webpage.

## Consuming Cortex

To consume data from Cortex, start by setting up authorization. See Cortex's [OmniAuth strategy](https://github.com/cb-talent-development/omniauth-cortex) for more instructions. You'll also need to set up OAuth credentials for your consuming application in the 'Applications' section of the Cortex admin interface.

### Content

Content can be consumed from a feed or via the resource's endpoint directly. Use the [cortex-client](https://github.com/cbdr/cortex-client) gem to easily consume any content resource and use it in your application.

### Localizations

Localizations can be consumed via the client or via [i18n-backend-cortex](https://github.com/cortex-cms/i18n-backend-cortex), which allows easy localization for Rails applications.

### Webpages and Snippets

Webpages/Snippets can be consumed via the client or via the [content-snippets-view](https://github.com/cortex-cms/content-snippets-view) and [content-snippets](https://github.com/cortex-cms/content-snippets) libraries, which need to be configured and hosted in order to be consumed.

### Exceptions

If a consuming or companion application would like to produce Cortex-equivalent exceptions, use the [cortex-exceptions](https://github.com/cb-talent-development/cortex-exceptions) gem.

## Applications Using Cortex

* [Advice and Resources](https://github.com/cbdr/advice-and-resources) - Redesigned Workbuzz/Advice & Resources platform utilizing Cortex Posts and Rails. [Live Site](http://advice.careerbuilder.com/)
* [Employer](https://github.com/cbdr/employer) - Redesigned Employer Marketing platform utilizing Cortex Webpages/Snippets and Rails. [Live Site](http://hiring.careerbuilder.com/)
* [CB1 Lander Shell](https://github.com/cbdr/cb1-lander-shell) - Platform for hosting lander pages and experiments, utilizing Cortex Posts and Sinatra. [Live Site](http://corporate.careerbuilder.com/)

## Contributing

Anyone and everyone is encouraged to fork Cortex and submit pull requests, propose new features and create issues.

Review [CONTRIBUTING](CONTRIBUTING.md) for complete instructions before you submit a pull request or feature proposal.

## License

Cortex utilizes the Apache 2.0 License. See [LICENSE](LICENSE) for details.

## Copyright

Copyright (c) 2016 CareerBuilder, LLC.

[cb-ce-github]: https://github.com/cb-talent-development "Content Enablement on GitHub"
