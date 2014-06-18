angular.module('cortex.controllers.posts.edit', [
  'ui.router.state',
  'ui.bootstrap.dropdown',
  'ui.bootstrap.buttons',
  'ui.bootstrap.datepicker',
  'ui.bootstrap.datetimepicker',
  'angular-flash.service',
  'angular-redactor',
  'cortex.directives.modalShow',
  'cortex.services.cortex',
  'cortex.filters',
  'cortex.settings',
  'cortex.vendor.underscore',
  'ngTagsInput',
  'cortex.services.mediaConstraints'
])

.controller('PostsEditCtrl', function($scope, $state, $stateParams, $window, $timeout, $q, $filter, flash, _, cortex, mediaSelectType, post, filters, categoriesHierarchy, currentUser, PostBodyEditorService, PostsPopupService, featuredMediaConstraintsService, tileMediaConstraintsService) {

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
        $state.go('^.manage.components');
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

  $scope.loadTags = function (search) {
    return cortex.posts.tags({s: search}).$promise;
  };

  $scope.data.popularTags = cortex.posts.tags({popular: true});

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

  // Auto-generate slug when title changed and field isn't dirty
  $scope.$watch('data.post.title', function(title) {
    if ($scope.postForm.slug.$dirty && $scope.postForm.slug) {
      return;
    }
    $scope.data.post.slug = $filter('slugify')($scope.data.post.title);
  });

  $scope.$watch('data.post.slug', function(slug) {

    if (!slug) {
      return;
    }

    cortex.posts.get({id: slug},
      // Slug already used
      function(post) {
        // A post may have its own slug
        if (post.id === $scope.data.post.id) {
          $scope.postForm.slug.$error.unavailable = false;
          $scope.data.postWithDuplicateSlug = null;
        }
        else {
          $scope.postForm.slug.$error.unavailable = true;
          $scope.data.postWithDuplicateSlug = post;
        }
      },
      // Slug unused
      function() {
        $scope.postForm.slug.$error.unavailable = false;
        $scope.data.postWithDuplicateSlug = null;
      }
    );
  });

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
    minHeight: 400
  };

  $scope.postBodyEditorService = PostBodyEditorService;
  $scope.postBodyEditorService.media.featured = $scope.data.post.featured_media;
  $scope.postBodyEditorService.media.tile = $scope.data.post.tile_media;

  $scope.featuredMediaConstraintsService = featuredMediaConstraintsService;
  $scope.tileMediaConstraintsService = tileMediaConstraintsService;


  var setMedia = function(type, title) {
    $scope.postBodyEditorService.mediaSelectType = type;
    PostsPopupService.title = title;
    $state.go('.media.manage.components');
  };

  $scope.setFeaturedMedia = function () {
    setMedia(mediaSelectType.SET_FEATURED, 'Set Featured Media from Media Library');
  };

  $scope.removeFeaturedMedia = function () {
    $scope.data.post.featured_media = {};
    $scope.data.post.featured_media_id = null;
    $scope.data.featured_media_too_small = false;
  };

  $scope.setTileMedia = function () {
    setMedia(mediaSelectType.SET_TILE, 'Set Tile Media from Media Library');
  };

  $scope.removeTileMedia = function () {
    $scope.data.post.tile_media = {};
    $scope.data.post.tile_media_id = null;
    $scope.data.tile_media_too_small = false;
  };

  $scope.$watch('postBodyEditorService.media.featured', function (media) {
    if (media) {
      $scope.data.post.featured_media = media;
      $scope.data.post.featured_media_id = media.id;
      $scope.data.post.featured_media_warnings = [];
      if (!$scope.featuredMediaConstraintsService.width(media)) {
        if ($scope.featuredMediaConstraintsService.totalSize(media)) {
          $scope.data.post.featured_media_warnings.push("Warning! Your featured media might appear stretched, as it is smaller than the featured image slot. Try an image at least 1100x600 ")
        }
        else {
          $scope.data.post.featured_media_warnings.push("Warning! Your featured media might appear stretched, as it is smaller than our recommended width of 1100px.")
        }
      }
      if (!$scope.featuredMediaConstraintsService.aspectratio(media)) {
        $scope.data.post.featured_media_warnings.push("Warning! Your featured media might appear, as it does not match our recommended aspect ratio. Try 16:9");
      }
    }
  });

  $scope.$watch('postBodyEditorService.media.tile', function (media) {
    if (media) {
      $scope.data.post.tile_media = media;
      $scope.data.post.tile_media_id = media.id;
      $scope.data.post.tile_media_warnings = [];
      if (!$scope.tileMediaConstraintsService.width(media)) {
        $scope.data.post.tile_media_warnings.push("Warning! Your tile media might appear stretched, as it is smaller than our recommended width of 375.");
      }
      if (!$scope.tileMediaConstraintsService.aspectratio(media)) {
        $scope.data.post.tile_media_warnings.push("Warning! Your tile media might not display properly, as it does not match our recommended aspect ratio. Try 1:1 or 4:3.");
      }
    }
  });

  // Adds a tag to tag_list if it doesn't already exist in array
  $scope.addTag = function(tag) {
    if (_.some($scope.data.post.tag_list, function(t) { return t.name == tag.name; })) {
      return;
    }
    $scope.data.post.tag_list.push({name: tag.name, id: tag.id});
  };
})

.factory('PostBodyEditorService', function($filter) {
  return {
    redactor: {},
    mediaSelectType: '',
    media: {
      featured: {},
      tile: {}
    },
    addMediaToPost: function (media) {
      this.redactor.insertHtml($filter('mediaToHtml')(media));
    }
  };
});
