var module = angular.module('cortex.controllers.media.new', [
    'ui.router.state',
    'ui.bootstrap.datepicker',
    'ui.bootstrap.progressbar',
    'angularFileUpload',
    'angular-flash.service',
    'cortex.settings'
]);

module.controller('MediaNewCtrl', function($scope, $timeout, $upload, $state, flash, settings) {

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

    $scope.data = {
        upload: {
            progress: 0,
            file: null
        },
        media: {}
    };

    $scope.startUpload = function() {

        var file = $scope.data.upload.file;

        if (!file) {
            return;
        }

        var httpConfig = {
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

        var uploadError = false;

        $scope.upload = $upload.upload(httpConfig)
            .progress(function(e) {
                if (uploadError) {
                    return;
                }
                $scope.data.upload.progress = parseInt(100.0 * e.loaded / e.total);
            })
            .success(function(media) {
                flash.success = media.name + " created";
                $state.go('^.manage.components');
            })
            .error(function(error, status) {
                uploadError = true;
                $scope.data.upload.progress = 0;
                $scope.data.upload.file = null;

                if (status === 422) {
                    flash.error = "Selected file type is not supported. Please choose a different file.";
                }
                else {
                    flash.error = "Unhandled error";
                }
            });
    };

    $scope.onFileSelect = function(files) {
        var file = files[0];
        $scope.data.upload.file = file;
    };

    $scope.remove = function() {
        $scope.data.upload.file = null;
    };
});