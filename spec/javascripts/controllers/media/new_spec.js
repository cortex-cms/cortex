//= require spec_helper

(function() {
  'use strict';

  describe('Media New Module', function() {

    beforeEach(function() {
      debaser()
          .module('cortex.controllers.media.new')
          .object('settings', {})
          .object('$state').withFunc('go').returnsArg(0)
          .withFunc('cortex').returns(sinon.stub())
          .object('$upload').withFunc('upload').fulfills(true)
          .debase();
    });

    describe('MediaGridCtrl', function() {
      var constructController;

      beforeEach(inject(function($controller) {
        constructController = function() {
          return $controller('MediaNewCtrl', { });
        };
      }));

      it('should construct', function() {
        var controller = constructController();
        expect(controller).toBeTruthy();
      });

      it('should provide data.media', function() {
        var controller = constructController();
        expect(controller.data.media).toBeDefined();
      });

      it('should allow the tab to be selected', function() {
        var controller = constructController();
        expect(controller.selectTab).toBeDefined();
        expect(controller.selectTab).toEqual(jasmine.any(Function));
        controller.selectTab('file');
        expect(controller.currentTab).toBe('file');
      });

      it('should provide cancel()', inject(function($state) {
        var controller = constructController();
        expect(controller.cancel).toBeDefined();
        expect(controller.cancel).toEqual(jasmine.any(Function));
        controller.cancel();
        expect($state.go.calledWith('^.manage.components')).toBeTruthy();
      }));

      it('should provide a saveMedia function', function() {
        var controller = constructController();
        expect(controller.saveMedia).toBeDefined();
        expect(controller.saveMedia).toEqual(jasmine.any(Function));
      });

      it('should save youtube', function() {
        var controller = constructController();
        sinon.stub(controller.data.media, '$save').fulfills({});
        angular.extend(controller.data.media, {video_id: '1234', name: 'Youtube video'});
        controller.selectTab('youtube');
        controller.saveMedia();
        expect(controller.data.media.$save.called).toBeTruthy();
      });

      it('should upload files', inject(function($upload) {
        var controller = constructController();
        controller.selectTab('file');
        controller.data.media.$file = {name: 'file'};
        angular.extend(controller.data.media, {name: 'File', attachment: true});
        controller.saveMedia();
        expect($upload.upload.called).toBeTruthy();
      }));


    });
  });
})();
