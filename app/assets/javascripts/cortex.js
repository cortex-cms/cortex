angular.module('cortex', [
  // Libraries/Vendor
  'ui.router',
  'ui.router.state',
  'angular-flash.service',
  'angular-flash.flash-alert-directive',
  'ncy-angular-breadcrumb',
  'ng-rails-csrf',

  // Cortex
  'cortex.states',
  'cortex.session',
  'cortex.vendor.moment'
])

.config(function ($provide, $urlRouterProvider, $httpProvider, flashProvider) {
  var copy = angular.copy;

  $provide.constant('currentUser', copy(window.gon.current_user));
  $provide.constant('settings', copy(window.gon.settings));

  $urlRouterProvider.when('/media/', '/media///');

  $urlRouterProvider.otherwise(function($injector) {
    var $state = $injector.get('$state');

    if ($injector.get('currentUser')) {
      $state.go('cortex.organizations.manage')
    }
    else {
      $state.go('login');
    }
  });

  // Override the default Accept header value of 'application/json, text/plain, */*'
  // as "*/*" invalidates all specificity.
  // https://github.com/rails/rails/issues/9940
  // http://blog.bigbinary.com/2010/11/23/mime-type-resolution-in-rails.html
  $httpProvider.defaults.headers.common['Accept'] = 'application/json, text/plain';

  // Add Bootstrap classes to flash element
  flashProvider.warnClassnames.push('alert-warning');
  flashProvider.infoClassnames.push('alert-info');
  flashProvider.successClassnames.push('alert-success');
  flashProvider.errorClassnames.push('alert-danger');
})

// CortexAdminCtrl
// ---------------
// Cortex's root-level application controller
.controller('CortexCtrl', function ($rootScope, $scope, $state, $stateParams, $http, $window, currentUser, moment) {
  var isDefined = angular.isDefined;
  // Add $state and $stateParams to root scope for universal access within views
  $rootScope.$state       = $state;
  $rootScope.$stateParams = $stateParams;
  $rootScope.currentUser  = currentUser;
  $rootScope.moment       = moment;

  $scope.$on('$stateChangeSuccess', function (event, toState, toParams, fromState, fromParams) {
    if (isDefined(toState.data) && isDefined(toState.data.pageTitle)) {
      $scope.pageTitle = toState.data.pageTitle + " | Cortex";
    }
  });

  // Push page views google analytics, if available
  if ($window._gaq) {
    $scope.$on('$viewContentLoaded', function(event) {
      $window._gaq.push(['_trackPageview', $location.path()]);
    });
  }

  $rootScope.logout = function() {
    $http.delete('/users/sign_out.json').success(function() {
      $window.location.href = "/";
    });
  };
});
