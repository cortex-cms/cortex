//= require spec_helper

(function() {
  'use strict';

  describe('Media Grid Module', function() {

    beforeEach(function() {
      var media = [{id: 1}, {id: 2}];
      var searchPaged = function(args, successFn) {
        var paging = {per_page: 10, page: 1};
        if (args) {
          paging = angular.extend(paging, args);
        }

        if (successFn) {
          successFn(media, {}, paging);
        }

        return media;
      };
      debaser()
          .module('cortex.controllers.media.grid')
          .object('settings', { paging: { defaultPerPage: 10 } } )
          .object('$stateParams', { query: '', page: 1 } )
          .object('$state').withFunc('go').returns(true)
          .object('media', media)
          .object('mediaSelectType', {})
          .object('$window').withFunc('confirm').returns(true)
          .object('cortex', { media: { delete: function(a, s) { s() }, searchPaged: searchPaged } } )
          .object('PostsPopupService', { popupOpen: false } )
          .object('mediaSelectType', { })
          .object('PostBodyEditorService', { })
          .debase();
    });

    describe('MediaGridCtrl', function() {
      var constructController;

      beforeEach(inject(function($controller) {

        constructController = function() {
          return $controller('MediaGridCtrl', {});
        };
      }));

      it('should construct', function() {
        var controller = constructController();
        expect(controller).toBeTruthy();
      });

      describe('$scope.page', function() {

        it('should provide query', inject(function($stateParams) {
          $stateParams.query = 'query';
          var controller = constructController();
          expect(controller.page.query).toEqual('query');
        }));

        it('should use $stateParams.page if available', inject(function($stateParams) {
          $stateParams.page = 2;
          var controller = constructController();
          expect(controller.page.page).toEqual(2);
        }));

        it('should provide default page', function() {
          var controller = constructController();
          expect(controller.page.page).toEqual(1);
        });

        it('should provide default perPage', function() {
          var controller = constructController();
          expect(controller.page.perPage).toEqual(10);
        });

        it('should use $stateParams.perPage if available', inject(function($stateParams) {
          $stateParams.perPage = 23;
          var controller = constructController();
          expect(controller.page.perPage).toEqual(23);
        }));

        it('should provide next()', function() {
          var controller = constructController();
          controller.page.next();
          expect(controller.page.page).toEqual(2);
        });

        it('should provide previous()', function() {
          var controller = constructController();
          controller.page.previous();
          expect(controller.page.page).toEqual(0);
        });
      });

      it('should provide data.media', function() {
        var controller = constructController();
        expect(controller.data.media.length).toEqual(2);
      });

      it('should provide deleteMedia()', function() {
        var controller = constructController();
        controller.deleteMedia({id: 1});
        expect(controller.data.media).not.toContain({id: 1});
      });
    });
  });
})();
