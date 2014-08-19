//= require spec_helper

(function() {
  'use strict';

  describe('Media Edit Module', function() {
    beforeEach(function() {
      debaser()
          .module('cortex.controllers.media.edit')
          .object('$state').withFunc('go').returns(true)
          .object('$stateParams', { mediaId: '' } )
          .withFunc('cortex').returns({ media: { tags: [] } } )
          .object('unsavedChanges').withFunc('fnListen').returns(true)
          .debase();
    });

    describe('MediaEditCtrl', function() {
      var constructController;

      beforeEach(inject(function($controller) {
        constructController = function() {
          return $controller('MediaEditCtrl', {});
        }
      }));

      it('should construct', function() {
        var controller = constructController();
        expect(controller).toBeTruthy();
      });

    });
  });

})();