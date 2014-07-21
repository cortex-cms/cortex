angular.module('cortex.controllers.posts.edit', [
  'ui.router.state',
  'ui.bootstrap.dropdown',
  'ui.bootstrap.buttons',
  'ui.bootstrap.datepicker',
  'ui.bootstrap.datetimepicker',
  'angular-flash.service',
  'angular-redactor',
  'cortex.services.cortex',
  'cortex.services.addMedia',
  'cortex.vendor.underscore',
  'frapontillo.bootstrap-switch'
])

.controller('PostsEditCtrl', function($scope, $rootScope, $state, $stateParams, $window, $timeout, $q, flash, _,
                                      cortex, post, filters, categoriesHierarchy, currentUser, AddMediaService) {

  $scope.data = {
    savePost: function() {
      $scope.$broadcast('validate');
      if ($scope.postForm.$invalid) {
        angular.element('.form-status').toggleClass('hidden', !$scope.postForm.$invalid);
        return;
      }
      // Find selected categories
      var selectedCategories = _.filter($scope.data.jobPhaseCategories, function(category) { return category.$selected; });
      $scope.data.post.category_ids = _.map(selectedCategories, function(category) { return category.id; });
      $scope.data.post.primary_category_id = $scope.data.post.category_ids[0];
      $scope.data.post.industry_ids = [$scope.data.post.primary_industry_id];
      $scope.data.post.tag_list = $scope.data.post.tag_list.map(function(tag) { return tag.name; });

      $scope.data.post.$save(function(post) {
        flash.success = 'Saved "' + post.title + '"';
        $state.go('^.^.^.manage.components');
      });
    },
    phases: _.map(filters.job_phases, function(job_phase) {
      return job_phase.name;
    }),
    industries: filters.industries
  };

  AddMediaService.initRedactorWithMedia();

  $scope.redactorOptions = {
    plugins: ['media'],
    toolbarFixedBox: true,
    minHeight: 800
  };

  if (post) {
    $scope.data.post = post;

    if ($scope.data.post.industry) {
      $scope.data.post.industry_id = $scope.data.post.industry.id;
    }

    var selectedCategoryIds = _.map(post.categories, function(c) { return c.id; });
    _.each(categoriesHierarchy, function(category){
      _.each(category.children, function(child){
        if (_.contains(selectedCategoryIds, child.id)) {
          child.$selected = true;
        }
      });
    });

    $scope.data.categories = categoriesHierarchy;
  }
  else {
    $scope.data.post = new cortex.posts();
    $scope.data.post.body = '';
    $scope.data.post.draft = true;
    $scope.data.post.author = currentUser.full_name;
    $scope.data.post.copyright_owner = $scope.data.post.copyright_owner || "CareerBuilder, LLC";
    $scope.data.categories = categoriesHierarchy;
    $scope.data.post.tag_list = '';
  }

  $scope.datepicker = {
    format: 'MMMM dd yyyy, h:mm:ss a',
    expireAtOpen: false,
    publishAtOpen: false,
    open: function(datepicker) {
      $timeout(function(){
        $scope.datepicker[datepicker] = true;
      });
    }
  };
});
