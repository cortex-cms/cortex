//= require spec_helper

(function() {
  'use strict';

  describe('Post Editor Module', function() {
    beforeEach(function() {
      debaser()
        .module('cortex.controllers.posts.edit')
        .object('AddMediaService').withFunc('initRedactorMediaPlugin').returns({ })
        .object('ImageFitService').withFunc('initRedactorImageFitPlugin').returns({ })
        .object('currentUserAuthor', { full_name: "Test User"})
        .object('filters', { job_phases: [], industries: [] })
        .object('$state', { go: function() { return { } }, includes: function() { return true } } )
        .object('mediaSelectType', { })
        .object('post', { })
        .object('categoriesHierarchy', { })
        .debase()
    });

    describe('PostsEditCtrl', function() {
      beforeEach(inject(function($controller) {
        constructController = function() {
          return $controller('PostsEditCtrl', {});
        };
      }));

      it('should construct', function() {
        var controller = constructController();
        expect(controller).toBeTruthy();
      });

      it('should provide data.industries on scope', function() {
        var controller = constructController();
        expect(controller.data.industries).toBeDefined();
      });

      it('should provide data.post on scope', function() {
        var controller = constructController();
        expect(controller.data.post).toBeDefined();
      });

      it('should provide data.categoriesHierarchy on scope', function() {
        var controller = constructController();
        expect(controller.data.categoriesHierarchy).toBeDefined();
      });

      it('should set data.authorIsUser to true if creating a new post', function() {
        var controller = constructController();
        expect(controller.data.authorIsUser).toBeTruthy();
      });

      it('should set data.authorIsUser to true if editing a post that has an author', function() {
        var controller = constructController();
        controller.data.post.author = { id: 1, first_name: "Calvin" };
        controller.data.post.id = 1;
        expect(controller.isAuthorUser(controller.data.post)).toBeTruthy();
      });

      it('should not set data.authorIsUser if editing a post that has a custom author', function() {
        var controller = constructController();
        controller.data.post.custom_author = "Hobbes";
        controller.data.post.id = 1;
        expect(controller.isAuthorUser(controller.data.post)).toBeFalsy();
      });
    });
  });
})();
