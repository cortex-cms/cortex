angular.module('cortex.controllers.media.bulk', [
  'ui.router.state',
  'ui.bootstrap.progressbar',
  'angular-flash.service',
  'angularFileUpload',
  'cortex.settings',
  'cortex.services.cortex',
  'cortex.directives.fileSelector'
])

  .controller('MediaBulkCtrl', function ($scope, $timeout, $upload, $state, $q, flash, cortex, settings) {
    $scope.data = $scope.data || {};
    $scope.data.mediaBulk = new cortex.media.bulkJob();
    $scope.data.upload = {
      progress: 0
    };

    function saveBulkJob() {
      var d = $q.defer();

      if (!$scope.data.mediaBulk.metadata) {
        d.reject('No metadata present.');
      }
      else {
        var uploadError = false;
        var httpConfig = {
          url: settings.cortex_base_url + '/media/bulk_job',
          method: 'POST',
          fields: {bulkJob: $scope.data.mediaBulk},
          formDataAppender: function (formData, key, value) {
            if (key === 'bulkJob') {
              angular.forEach(value, function (v, k) {
                formData.append('bulkJob[' + k + ']', v);
              });
            }
          }
        };

        $scope.data.upload.progress = 1;
        $scope.data.upload = $upload.upload(httpConfig)
          .then(
          function (bulkJob) { //Success
            d.resolve();
          },
          function (error, status) { //Error
            uploadError = true;
            $scope.data.upload.progress = 0;
            $scope.data.upload.file = null;

            if (status === 422) {
              d.reject('Selected file type is not supported. Please choose a different file.');
            }
            else {
              d.reject('Unhandled error: ' + error.data.errors[0]);
            }
          },
          function (e) { //Progress
            if (uploadError) {
              return;
            }
            $scope.data.upload.progress = parseInt(100.0 * e.loaded / e.total);
          }
        );
      }

      return d.promise;
    }

    $scope.saveMediaBulk = function () {
      saveBulkJob().then(
        function () {
          flash.success = 'Bulk job created';
          $state.go('cortex.bulk_jobs.manage');
        },
        function (error) {
          flash.error = error;
        });
    };

    $scope.cancel = function () {
      $state.go('^.manage.components');
    };
  });
