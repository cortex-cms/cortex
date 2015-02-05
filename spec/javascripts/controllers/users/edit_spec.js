//= require spec_helper

(function() {
  'use strict';

  describe('User Profile Module', function() {
    beforeEach(function() {
      debaser()
          .module('cortex.controllers.users.profile')
          .object('$scope', {})
          .object('user', {})
          .object('author').withFunc('$save').fulfills({})
          .debase();
    });

    describe('UsersProfileCtrl', function() {
      var constructController;

      beforeEach(inject(function($controller) {
        constructController = function() {
          return $controller('UsersProfileCtrl', {});
        };
      }));

      it('should construct', function() {
        var controller = constructController();
        expect(controller).toBeTruthy();
      });

      it('should save an author', function() {
        var controller = constructController();
        controller.saveAuthor();
        expect(controller.data.author.$save.called).toBeTruthy();
      });

    });

  });

})();
