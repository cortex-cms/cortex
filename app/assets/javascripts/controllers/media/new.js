angular.module('cortex.controllers.media.new', [
    'ui.router.state',
    'ui.bootstrap.datepicker',
    'ui.bootstrap.progressbar',
    'ui.bootstrap.tabs',
    'angular-flash.service',
    'cortex.settings',
    'cortex.services.cortex',
    'cortex.directives.fileSelector',
    'cortex.directives.youtubeSelector'
])

.controller('MediaNewCtrl', function($scope, $timeout, $upload, $state, flash, cortex, settings) {

  $scope.data            = $scope.data || {};
  $scope.data.currentTab = 'file;'
  $scope.data.media      = new cortex.media();
  $scope.data.upload     = {
    progress: 0
  };

  // angular-bootstrap datepicker settings
  $scope.datepicker = {
    format: 'yyyy/MM/dd',
    expireAtOpen: false,
    open: function(datepicker) {
      $timeout(function(){
        $scope.datepicker[datepicker] = true;
      });
    }
  };

  function saveFile() {
    $scope.data.media.type = 'Media';
    var file = $scope.data.media.$file;

    if (!file) { return; }

    var uploadError = false;
    var httpConfig  = {
      url: settings.cortex_base_url + '/media',
      method: 'POST',
      data: {media: $scope.data.media},
      file: file,
      fileFormDataName: 'media[attachment]',
      formDataAppender: function(formData, key, value) {
        if (key === 'media') {
          angular.forEach(value, function(v, k) {
            formData.append('media[' + k + ']', v);
          });
        }
      }
    };

    $scope.data.upload = $upload.upload(httpConfig)
      .progress(function(e) {
        if (uploadError) { return; }
        $scope.data.upload.progress = parseInt(100.0 * e.loaded / e.total);
      })
      .success(function(media) {
        flash.success = media.name + ' created ';
        $state.go('^.manage.components');
      })
      .error(function(error, status) {
        uploadError                 = true;
        $scope.data.upload.progress = 0;
        $scope.data.upload.file     = null;

        if (status === 422) {
          flash.error = 'Selected file type is not supported. Please choose a different file.';
        }
        else {
          flash.error = 'Unhandled error';
        }
      });
  };
  // </saveFile()>

  function saveYoutube() {
    $scope.data.media.type     = 'Youtube';
    $scope.data.media.video_id = $scope.data.media.$youtube.id;
    $scope.data.media.$save();
  };

  $scope.saveMedia = function() {
    var tab = $scope.currentTab;
    if (tab === 'file') {
      saveFile();
    }
    else if (tab === 'youtube') {
      saveYoutube();
    }
    else {
      flash.error = 'Unknown media-type tab "' + selectedTab + '"';
    }
  }

  $scope.selectTab = function(tab) {
    $scope.currentTab = tab;
  };
});