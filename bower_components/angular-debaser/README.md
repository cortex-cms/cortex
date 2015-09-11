# [angular-debaser](https://github.com/decipherinc/angular-debaser/) [![Build Status]
(https://travis-ci
.org/decipherinc/angular-debaser
.svg?branch=master)](https://travis-ci.org/decipherinc/angular-debaser) [![Coverage Status](https://img.shields.io/coveralls/decipherinc/angular-debaser.svg)](https://coveralls.io/r/decipherinc/angular-debaser?branch=master)

Just a better way to test AngularJS apps.

## The Idea

AngularJS and its dependency injection make it very easy to isolate your code under test.  
Unfortunately, coding up stubs for those services can get tedious (many services injected, 
many modules depending upon modules), and you could end up with a fixture that dwarfs your 
assertions.

**angular-debaser** attempts to reduce the size of your fixtures and make them natural to write.

## Example

Given the following beastly fixture and test:

```js
describe('AdminDashboardCtrl', function () {
  var sandbox;

  beforeEach(function () {
    sandbox = sinon.sandbox.create('AdminDashboardCtrl');
  });

  afterEach(function() {
    sandbox.restore();
  });

  beforeEach(module(function ($provide) {
    $provide.provider('User', function () {
      this.assertAdmin = sandbox.stub();
      this.$get = function() {
        return {
          getAll: sandbox.stub().returns([])
        };
      };
    });
    $provide.service('Settings', function() {
      this.location_id = 1;
    });
    $provide.service('Pizza', function() {
      this.getAll = sandbox.stub().returns([]);
    });
    $provide.service('Toppings', function() {
      this.getAll = sandbox.stub().returns({});
    });
    $provide.service('Sides', function() {
      this.getAll = sandbox.stub().returns([]);
    });
    $provide.service('Orders', function() {
      this.getPreviousWeek = sandbox.stub().returns([]);
    });
    $provide.service('Deliveries', function() {
      this.getPreviousWeek = sandbox.stub().returns([]);
    });
  }));

  beforeEach(module('donny.pizzajoint.admin'));

  it('should gather a list of users', inject(function ($controller, $rootScope, User) {
    var scope = $rootScope.$new();
    $controller('AdminDashboardCtrl', {
      $scope: scope
    });
    expect(scope.getUsers()).to.eql([]);
    expect(User.getAll).to.have.been.calledOnce;
  }));
});
```

We'll use **angular-debaser** instead.  It becomes this:

```js
describe('AdminDashboardCtrl', function () {
  beforeEach(function () {
    debaser()
      .module('donny.pizzajoint.admin')
      .object('Settings', {
        location_id: 1
      })
      .object('User').withFunc('getAll').returns([])
      .object('Pizza').withFunc('getAll').returns([])
      .object('Toppings').withFunc('getAll').returns({})
      .object('Sides').withFunc('getAll').returns([])
      .object('Orders').withFunc('getPreviousWeek').returns([])
      .object('Deliveries').withFunc('getPreviousWeek').returns([])
      .debase();
  });

  it('should gather a list of users',
    inject(function ($controller, User) {
      var scope = $controller('AdminDashboardCtrl');
      expect(scope.getUsers()).to.eql([]);
      expect(User.getAll).to.have.been.calledOnce;
    }));
});
```

(If you're counting, that's about half as many lines.)

Interested?  Trying to test something that injects 46 services??  You may want to read [the 
tutorial](http://decipherinc.github.io/angular-debaser/tutorial-donny-developer.html) & go down 
the rabbit hole.

## API

*If Sinon.JS is present, see [this API](http://sinonjs.org/docs/#stubs) for working with functions.*

See [the API documentation](http://decipherinc.github.io/angular-debaser/).

## Installation

```
bower install angular-debaser
```

Optionally, save it to your `bower.json`: you probably don't want to use `--save`; use `--save-dev`.

### Dependencies & Recommended Packages

Current dependencies:

  - [AngularJS](http://angularjs.org)
  - [angular-mocks](https://github.com/angular/bower-angular-mocks) 
  
Required, but not marked as dependencies:
 
  - [Mocha](http://visionmedia.github.io/mocha/) w/ [Chai](http://chaijs.com) *or*
  - [Jasmine](http://jasmine.github.io/)

Recommended:

  - [sinon-ng](http://github.com/boneskull/sinon-ng) for working with `$q`; `bower install sinon-ng`

Depending on your test runner setup, you may want to install these either via `bower` or `npm`:

  - [Sinon.JS](http://sinonjs.org) for stubbing/spying
  - [Sinon-Chai](https://github.com/domenic/sinon-chai) or [jasmine-sinon](https://github.com/froots/jasmine-sinon) for BDD-style Sinon.JS integration.
  - [Chai-as-Promised](https://github.com/domenic/chai-as-promised/) for Chai assertions against Promises

  > If you're using [Karma](http://karma-runner.github.io/) as a test runner w/ Chai, you may want to grab [karma-chai-plugins](https://www.npmjs.org/package/karma-chai-plugins) to get Sinon-Chai and Chai-as-Promised.

Also, if you are [testing directives](https://github.com/vojtajina/ng-directive-testing), I've found that [jQuery](http://jquery.com) is always handy to have around.

## Issues

[Issues here](https://github.com/decipherinc/angular-debaser/issues/).

## License

Copyright &copy; 2014 [Decipher, Inc.](http://decipherinc.com)  Licensed MIT.

## Maintainer

[Christopher Hiller](http://github.com/boneskull)

