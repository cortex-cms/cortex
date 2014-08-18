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
      var createController;

      beforeEach(inject(function($controller) {

        createController = function() {
          return $controller('MediaGridCtrl', {});
        };
      }));

      it('should construct', function() {
        var controller = createController();
        expect(controller).toBeTruthy();
      });

      describe('$scope.page', function() {

        xit('should provide query', function() {
          // TODO: Figure out stateParams being variable
          var query = 'query';
          var controller = createController();
          expect(controller.page.query).toEqual(query);
        });

        xit('should use $stateParams.page if available', function() {
          // TODO: Figure out stateParams being variable
          var page = 2;
          var controller = createController();
          expect(controller.page.page).toEqual(page);
        });

        it('should provide default page', function() {
          var controller = createController();
          expect(controller.page.page).toEqual(1);
        });

        it('should provide default perPage', function() {
          var controller = createController();
          expect(controller.page.perPage).toEqual(10);
        });

        xit('should use $stateParams.perPage if available', function() {
          // TODO: Figure out stateParams being variable
          var perPage = 23;
          var controller = createController();
          expect(controller.page.perPage).toEqual(perPage);
        });

        it('should provide next()', function() {
          var controller = createController();
          controller.page.next();
          expect(controller.page.page).toEqual(2);
        });

        it('should provide previous()', function() {
          var controller = createController();
          controller.page.previous();
          expect(controller.page.page).toEqual(0);
        });
      });

      it('should provide data.media', function() {
        var controller = createController();
        expect(controller.data.media.length).toEqual(2);
      });

      it('should provide deleteMedia()', function() {
        var controller = createController();
        controller.deleteMedia({id: 1});
        expect(controller.data.media).not.toContain({id: 1});
      });
    });
  });
})();
