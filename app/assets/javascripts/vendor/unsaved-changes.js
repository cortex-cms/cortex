(function() {
    var mosUnsavedChanges;

    mosUnsavedChanges = angular.module('unsavedChanges', []);

    mosUnsavedChanges.service('unsavedChanges', [
        '$rootScope', '$window', function($rootScope, $window) {
            var MESSAGE, fnHash, fnLocationListener, fnStateListener;
            MESSAGE = "Are you sure you don't want to save changes?";
            fnLocationListener = null;
            fnStateListener = null;
            this.fnListen = function($scope, mListenableObject) {
                var sInitialHash,
                    _this = this;
                this.fnRemoveListener();
                sInitialHash = fnHash(mListenableObject);
                fnLocationListener = $rootScope.$on('$locationChangeStart', function(event) {
                    var sFinalHash;
                    sFinalHash = fnHash(mListenableObject);
                    if (sFinalHash !== sInitialHash && !confirm(MESSAGE)) {
                        return event.preventDefault();
                    } else {
                        return _this.fnRemoveListener();
                    }
                });
                fnStateListener = $rootScope.$on('$stateChangeStart', function(event) {
                    var sFinalHash;
                    sFinalHash = fnHash(mListenableObject);
                    if (sFinalHash !== sInitialHash && !confirm(MESSAGE)) {
                        return event.preventDefault();
                    } else {
                        return _this.fnRemoveListener();
                    }
                });
                $window.onbeforeunload = function(event) {
                    var sFinalHash;
                    sFinalHash = fnHash(mListenableObject);
                    if (sFinalHash !== sInitialHash) {
                        if (typeof event === "undefined") {
                            event = window.event;
                        }
                        if (event != null) {
                            event.returnValue = MESSAGE;
                        }
                        return MESSAGE;
                    }
                };
                return $scope.$on('$destroy', function() {
                    return _this.fnRemoveListener();
                });
            };
            this.fnRemoveListener = function() {
                if (fnLocationListener != null) {
                    fnLocationListener();
                }
                if (fnStateListener != null) {
                    fnStateListener();
                }
                return $window.onbeforeunload = null;
            };
            fnHash = function(something) {
                return angular.toJson(something);
            };
        }
    ]);

}).call(this);
