angular.module('cortex.controllers.webpages.edit', [
    'ui.router.state',
    'angular-flash.service',
    'cortex.services.cortex',
    'cortex.filters'
  ])

  .controller('WebpagesEditCtrl', function ($scope, $window, $document, $state, $stateParams, $anchorScroll, flash, cortex) {
    $scope.data = $scope.data || {};
    $scope.data.webpage = cortex.webpages.get({id: $stateParams.webpageId});

    var frameEventListener = function (event) {
      switch (event.data.event) {
        case 'cancel_editor':
          cancel();
          break;
        case 'save_webpage':
          saveWebpage(event.data.webpage);
          break;
        case 'get_medias':
          getMedias(event.data.page).$promise.then(function (media) {
            sendFrameMessage({event: 'medias_data', medias: media});
          });
          break;
      }
    };

    $window.addEventListener('message', frameEventListener, false);
    $scope.$on("$destroy", function(){
      $window.removeEventListener('message', frameEventListener, false);
    });

    // Perhaps this should moved to a directive!
    var sendFrameMessage = function (data) {
      document.getElementById('webpage-frame').contentWindow.postMessage(JSON.parse(JSON.stringify(data)), '*');
    };

    var cancel = function () {
      $state.go('^.manage');
    };

    var saveWebpage = function (webpage) {
      delete $scope.data.webpage.snippets;

      var snippets_attributes = [];
      _.each(webpage.snippets, function (value) {
        snippets_attributes.push({
          id: value.id,
          document_attributes: value.document
        });
      });

      $scope.data.webpage.snippets_attributes = snippets_attributes;
      $scope.data.webpage.seo_keyword_list = $scope.data.webpage.seo_keyword_list.map(function(seo_keyword) { return seo_keyword.name; });
      $scope.data.webpage.$save().then(
        function () {
          $anchorScroll();
          flash.success = 'Saved Webpage information';
          $state.go('^.manage');
        },
        function () {
          $anchorScroll();
          flash.error = 'Error while saving Webpage information';
        }
      );
    };

    var getMedias = function (page) {
      return cortex.media.searchPaged({
        q: page.query,
        per_page: page.perPage,
        page: page.page
      });
    }
  });
