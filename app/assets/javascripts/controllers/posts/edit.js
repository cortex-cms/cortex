angular.module('cortex.controllers.posts.edit', [
  'ui.router.state',
  'ui.bootstrap.dropdown',
  'ui.bootstrap.buttons',
  'ui.bootstrap.datepicker',
  'ui.bootstrap.datetimepicker',
  'angular-flash.service',
  'angular-redactor',
  'cortex.services.cortex',
  'cortex.vendor.underscore'
])

.controller('PostsEditCtrl', function($scope, $state, $stateParams, $window, $timeout, $q, flash, _, cortex, post, filters, categoriesHierarchy, currentUser, PostBodyEditorService) {

  $scope.data = {
    savePost: function() {
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
    phases: [
      'discovery',
      'find_the_job',
      'get_the_job',
      'on_the_job'
    ],
    industries: filters.industries,
    scheduled: [
      true,
      false
    ]
  };

  var initializePost  = function() {
    $scope.$watch('data.post.job_phase', function(phase) {

      if (phase === undefined) {
        $scope.data.jobPhaseCategories = [];
        return;
      }

      var jobPhaseCategory = _.find($scope.data.categories, function(category) {
        var normalizedPhaseName = category.name.split(' ').join('_').toLowerCase();
        return normalizedPhaseName == phase;
      });

      $scope.data.jobPhaseCategories = jobPhaseCategory.children;
    });
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

    var todayDate = moment(new Date());
    var postDate = moment($scope.data.post.published_at);

    if ($scope.data.post.draft === false && postDate.diff(todayDate, 'days') < 1 ) {
      $scope.data.scheduled = false;
    }
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
  initializePost();

  // angular-bootstrap datetimepicker settings
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

  $scope.postScheduling = {
    now: function() {
      $scope.data.post.published_at = new Date();
    },
    scheduled: function() {
      $scope.data.post.published_at = null || $scope.data.post.published_at;
    }
  };

  $scope.postBodyEditorService = PostBodyEditorService;

  if (!$window.RedactorPlugins) {
    $window.RedactorPlugins = {};
  }

  $window.RedactorPlugins.media = {
    init: function()
    {
      this.buttonAdd('media', 'Media', this.addMediaPopup);
      this.buttonAwesome('media', 'fa-picture-o');

      this.buttonRemove('image');
      this.buttonRemove('video');

      PostBodyEditorService.redactor = this;
    },
    addMediaPopup: function()
    {
      setMedia(mediaSelectType.ADD_MEDIA, 'Insert Media from Media Library');
    }
  };

  $scope.redactorOptions = {
    plugins: ['media'],
    toolbarFixedBox: true,
    minHeight: 800
  };
});
