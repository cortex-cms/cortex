//= require helpers/window_helper

(function () {
  'use strict';

  describe("Cortex Service", function () {
    beforeEach(function () {
      angular.mock.module('cortex.services.cortex');
    });

    describe("Cortex factory", function () {
      var $httpBackend, cortexResource;
      beforeEach(function () {

        inject(function ($injector) {
          $httpBackend = $injector.get('$httpBackend');
          cortexResource = $injector.get('cortex');
        });

      });

      it("should have a posts object.", function () {
        expect(cortexResource.posts).toBeDefined();
      });

      it("should recognize paginated responses.", function () {
        $httpBackend.expectGET('/posts/feed?page=1').respond([], {'X-Total': '84'});
        cortexResource.posts.feedPaged({'page': 1});
        $httpBackend.flush();
      });

      it("should have a filters request.", function () {
        $httpBackend.expectGET('/posts/filters').respond({});
        cortexResource.posts.filters();
        $httpBackend.flush();
      });

      xit("should have a related request.", function () {
        $httpBackend.expectGET('/posts/feed/1/related').respond([
          {}
        ]);
        cortexResource.posts.related({id: 1});
        $httpBackend.flush();
      });

      it("should have a users object.", function () {
        expect(cortexResource.users).toBeDefined();
      });

      it("should be able to make a request to user.me.", function () {
        $httpBackend.expectGET('/users/me').respond({});
        cortexResource.users.me();
        $httpBackend.flush();
      });

    });

  });

})();
