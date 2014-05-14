angular.module('cortex.controllers.posts.edit', [
  'ui.router.state',
  'ui.bootstrap.dropdownToggle',
  'ui.bootstrap.buttons',
  'ui.bootstrap.datepicker',
  'ui.bootstrap.datetimepicker',
  'angular-flash.service',
  'angular-redactor',
  'cortex.directives.modalShow',
  'cortex.services.cortex',
  'cortex.filters',
  'cortex.util',
  'cortex.settings'
])

.controller('PostsEditCtrl', function($scope, $state, $stateParams, $window, $timeout, $q, $filter, flash, cortex, mediaSelectType, post, categories, currentUser, PostBodyEditorService, PostsPopupService) {

  $scope.data = {
    savePost: function() {
      // Find selected categories
      var selectedCategories = _.filter($scope.data.jobPhaseCategories, function(category) { return category.$selected; });
      $scope.data.post.category_ids = _.map(selectedCategories, function(category) { return category.id; });

      $scope.data.post.$save(function(post) {
        flash.success = 'Saved "' + post.title + '"';

        $state.go('^.manage.components');
      });
    },
    phases: [
      'discovery',
      'find_the_job',
      'get_the_job',
      'on_the_job'
    ],
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

    var selectedCategoryIds = _.map(post.categories, function(c) { return c.id; });
    _.each(categories, function(category){
      _.each(category.children, function(child){
        if (_.contains(selectedCategoryIds, child.id)) {
          child.$selected = true;
        }
      });
    });

    $scope.data.categories = categories;

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
    $scope.data.categories = categories;
  }
  initializePost();

  // angular-bootstrap datetimepicker settings
  $scope.datetimepicker = {
    format: 'MMMM Do YYYY, h:mm:ss a'
  };

  $scope.postScheduling = {
    now: function() {
      $scope.data.post.published_at = new Date();
    },
    scheduled: function() {
      $scope.data.post.published_at = null || $scope.data.post.published_at;
    }
  };

  if (!$window.RedactorPlugins) {
    $window.RedactorPlugins = {};
  }

  $window.RedactorPlugins.media = {
    init: function() {
      this.buttonAdd('media', 'Media', this.addMediaPopup);
      this.buttonAwesome('media', 'fa-picture-o');

      this.buttonRemove('image');
      this.buttonRemove('video');

      PostBodyEditorService.redactor = this;
    },
    addMediaPopup: function() {
      PostsPopupService.title = 'Insert Media from Media Library';
      PostBodyEditorService.mediaSelectType = mediaSelectType.ADD_MEDIA;
      $state.go('.media.manage.components');
    }
  };

  $scope.redactorOptions = {
    plugins: ['media'],
    minHeight: 400
  };

  $scope.postBodyEditorService = PostBodyEditorService;
  $scope.postBodyEditorService.featured = $scope.data.post.featured_media;

  $scope.setFeaturedImage = function() {
    PostsPopupService.title = 'Set Featured Image from Media Library';
    PostBodyEditorService.mediaSelectType = mediaSelectType.SET_FEATURED;
    $state.go('.media.manage.components');
  };

  $scope.removeFeaturedImage = function() {
    $scope.data.post.featured_media = {};
    $scope.data.post.featured_media_id = null;
    $scope.data.featured_media_too_small = false;
  };

  $scope.$watch('postBodyEditorService.featured', function(media) {
    if (media) {
      $scope.data.post.featured_media = media;
      $scope.data.post.featured_media_id = media.id;
      $scope.data.featured_media_too_small = media.dimensions[0] < 800
    }
  });
})

.factory('PostBodyEditorService', function($filter) {
  return {
    redactor: {},
    featured: {},
    addMediaToPost: function(media) {
      this.redactor.insertHtml($filter('mediaToHtml')(media));
    }
  };
});
