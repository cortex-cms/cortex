//= require spec_helper

(function() {
  'use strict';

  describe('User Edit Module', function() {
    beforeEach(function() {
      debaser()
          .module('cortex.controllers.users.edit')
          .object('$scope', {})
          .object('user', {})
          .object('author').withFunc('$save').fulfills({})
          .debase();
    });

    describe('UsersEditCtrl', function() {
      var constructController;

      beforeEach(inject(function($controller) {
        constructController = function() {
          return $controller('UsersEditCtrl', {});
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
