//= require spec_helper

(function() {
  'use strict';

  describe("Post Grid Module", function() {
    beforeEach(function() {
      debaser()
        .module('cortex.controllers.posts.grid')
        .object('cortex', {})
        .func('ngTableParams').returns({})
        .debase()
    });

    describe('PostsGridCtrl', function() {
      var constructController;
      beforeEach(inject(function($controller) {
        constructController = function() {
          return $controller('PostsGridCtrl');
        };
      }));

      it('should contstruct', function() {
        var controller = constructController();
        expect(controller).toBeTruthy();
      });
    });
  });
})();