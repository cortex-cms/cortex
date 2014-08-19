//= require spec_helper

(function() {
  'use strict';

  describe('Media Edit Module', function() {
    beforeEach(function() {
      debaser()
          .module('cortex.controllers.media.edit')
          .object('$stateParams', { mediaId: '' } )
          .object('$state').withFunc('go').returnsArg(0)
          .withFunc('cortex').returns({ })
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

      it('should provide an update function', function() {
        var controller = constructController();
        expect(controller.update).toBeDefined();
        expect(controller.update).toEqual(jasmine.any(Function));
      });

      it('should provide a cancel function', inject(function($state) {
        var controller = constructController();
        expect(controller.cancel).toBeDefined();
        expect(controller.cancel).toEqual(jasmine.any(Function));
        controller.cancel();
        expect($state.go.calledWith('^.manage.components')).toBeTruthy();
      }));

      it('should add a tag', inject(function(cortex) {
        sinon.stub(cortex.media, "get").returns({tag_list: []});
        var controller = constructController();
        var tag = {name: "Test Tag", id: 1};
        controller.addTag(tag);
        expect(controller.data.media.tag_list).toContain(tag);
      }));

      it('should save media edits', function() {
        var controller = constructController();
        sinon.stub(controller.data.media, '$save').fulfills({});
        angular.extend(controller.data.media, {video_id: '1234', name: 'Youtube video', tag_list: []});
        controller.update();
        expect(controller.data.media.$save.called).toBeTruthy();
      });

    });
  });

})();