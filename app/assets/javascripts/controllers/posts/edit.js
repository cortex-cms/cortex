angular.module('cortex.controllers.posts.edit', [
  'ui.router.state',
  'ui.bootstrap.dropdown',
  'ui.bootstrap.buttons',
  'ui.bootstrap.datepicker',
  'ui.bootstrap.datetimepicker',
  'angular-flash.service',
  'angular-redactor',
  'frapontillo.bootstrap-switch',

  'cortex.vendor.underscore',
  'cortex.services.addMedia'
])

.controller('PostsEditCtrl', function($scope, $state, $timeout, flash, _,
                                      post, filters, currentUserAuthor, categoriesHierarchy, AddMediaService) {
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

      if ($scope.data.authorIsUser) {
        $scope.data.post.custom_author = null;
        $scope.data.post.author_id = currentUserAuthor.id;
      } else {
        $scope.data.post.author_id = null;
      }

      $scope.data.post.$save(function(post) {
        flash.success = 'Saved "' + post.title + '"';
        $state.go('^.^.^.manage.components');
      });
    },
    cancel: function() {
      $state.go('^.^.^.manage.components');
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

  if (!post || (post && post.author)) {
    $scope.data.authorIsUser = true;
  }
  $scope.data.post = post;
  $scope.data.categoriesHierarchy = categoriesHierarchy;

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
