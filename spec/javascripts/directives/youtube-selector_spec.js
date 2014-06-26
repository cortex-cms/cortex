(function() {
  'use strict';

  describe('youtube-selector directive', function() {
    var elem, $scope;

    beforeEach(function() {
      module('cortex.directives.youtubeSelector');
      module('cortex.templates');
    });

    beforeEach(inject(function($compile, $rootScope) {
      $scope = $rootScope.$new();
      elem = angular.element('<youtube-selector ng-model="youtube"></youtube-selector>');
      $compile(elem)($scope);
      $scope.$digest();
    }));

    describe('with a valid YouTube URL', function() {
      var VALID_CODE = 'aBOzOVLxbCE';

      beforeEach(function() {
        var input = elem.find('input');
        input.val('http://www.youtube.com/watch?v=' + VALID_CODE);
        input.trigger('input');
      });

      it('should update ng-model', function() {
        expect($scope.youtube).toBe(VALID_CODE);
      });

      it('should embed the video', function() {
        expect(elem.find('iframe').attr('src')).toBe('http://www.youtube.com/embed/' + VALID_CODE);
      });
    });

    describe('with an invalid YouTube URL', function() {
      var INVALID_CODE = 'xyz';

      beforeEach(function() {
        var input = elem.find('input');
        input.val('http://www.youtube.com/watch?v=' + INVALID_CODE);
        input.trigger('input');
      });

      it('should NOT update ng-model', function() {
        expect($scope.youtube).toBe(null);
      });

      it('should NOT embed the video', function() {
        expect(elem.find('iframe').size()).toBe(0);
      });
    });
  });
})();
