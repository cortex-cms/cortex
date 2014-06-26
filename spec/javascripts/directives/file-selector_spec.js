(function() {
  'use strict';

  describe('file-selector directive', function() {
    var $scope, createDirective;

    beforeEach(function() {
      module('cortex.directives.fileSelector');
      module('cortex.templates');
    });

    beforeEach(inject(function($compile, $rootScope) {
      $scope = $rootScope.$new();

      createDirective = function(multiple) {
        if (multiple === undefined) {
          multiple = false;
        }
        $scope.multiple = multiple;
        var elem = angular.element('<file-selector ng-model="file" multiple="multiple"></file-selector>');
        $compile(elem)($scope);
        $scope.$digest();
        return elem;
      };
    }));

    it('should browse for files when the dropzone is clicked', function() {
      var elem                 = createDirective(false);
      var dropzone             = elem.find('.dropzone');
      var openFileDialogOpened = false;

      dropzone.scope().browseForFiles = function() {
        openFileDialogOpened = true;
      };
      elem.find('.dropzone').trigger('click');

      expect(openFileDialogOpened).toBe(true);
    });

    describe('when multiple=false', function() {
      var elem;

      beforeEach(function() {
        elem = createDirective(false);
      });

      it('should NOT allow multiple files to be selected', function() {
        var multiple = elem.find('input[type="file"][multiple]');
        expect(multiple.size()).toBe(0);
      });
    });

    describe('when multiple=true', function() {
      var elem;

      beforeEach(function() {
        elem = createDirective(true);
      });

      it('should allow multiple files to be selected', function() {
        var multiple = elem.find('input[type="file"][multiple]');
        expect(multiple.size()).toBe(1);
      });
    });

    it('should remove files when they are clicked', function() {
      var file             = {name: 'hilarious_meme.jpg'};
      var elem             = createDirective();
      // Grab a random child element to fetch the isolate scope
      var directiveScope   = elem.find('div').scope();
      directiveScope.files = [file, {name: 'foo.png'}];

      directiveScope.remove(file);
      expect(directiveScope.files).toNotContain(file);
    });

    it('should add a file dropped into the dropzone');
  });
})();
