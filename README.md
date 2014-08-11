# Cortex

[![Build Status](https://magnum.travis-ci.com/cbdr/cortex.svg?token=sAtZ4frpstZnGHoeyxTz&branch=master)](https://magnum.travis-ci.com/cb-talent-development/cortex)

Cortex is an identity, content management and reporting platform built by [Talent Development][td-github]. Its purpose is to provide central infrastructure for next-generation applications; exposing a single point of management while enabling quicker build-out of new software.

### Initial Setup

Copy the example .env file and modify

```sh
$ cp .env.example .env
```

### Setup - OS X

**Prerequisites:** Xcode, Ruby ([rvm](https://rvm.io/) or [rbenv](https://github.com/sstephenson/rbenv)), [Homebrew](http://brew.sh/)

1. Install all homebrew managed dependencies from the `Brewfile` via `$ brew bundle`
2. Start servers with `launchctl` or [lunchy](https://github.com/eddiezane/lunchy): `$ lunchy start elasticsearch`
3. Install Bundler and dependencies `$ gem install bundler && bundle install`
4. Create `cortex_dev` and `cortex_test` databases and users in PostgreSQL
5. Run migrations `$ rake db:migrate`
6. Seed database:

```sh
$ rake db:seed
$ rake cortex:create_categories
$ rake cortex:onet:fetch_and_provision
```
Finally, start Cortex: `$ rails s`

### Applications

- [Advice and Resources](https://github.com/cbdr/advice-and-resources) - Redesigned Workbuzz/Advice & Resources platform

[td-github]: https://github.com/cb-talent-development "Talent Development on GitHub"
