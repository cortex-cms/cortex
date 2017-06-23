angular.module('cortex.controllers.posts.edit', [
  'ui.router.state',
  'ui.bootstrap.dropdown',
  'ui.bootstrap.buttons',
  'ui.bootstrap.datepicker',
  'ui.bootstrap.datetimepicker',
  'angular-flash.service',
  'angular-redactor',
  'cortex.vendor.underscore',
  'cortex.services.addMedia',
  'cortex.services.imageFit'
])

.controller('PostsEditCtrl', function($scope, $state, $timeout, flash, _,
                                      post, filters, currentUserAuthor, categoriesHierarchy, AddMediaService, ImageFitService) {
  $scope.data = {
    savePost: function() {
      $scope.$broadcast('validateShowErrors');
      if ($scope.postForm.$invalid) {
        return;
      }
      $scope.data.post.category_ids = [];
      angular.forEach($scope.data.post.postCategories, function(value, key) {
        if (value) {
          this.push(key);
        }
      }, $scope.data.post.category_ids);
      $scope.data.post.primary_category_id = $scope.data.post.category_ids[0];
      $scope.data.post.industry_ids = [$scope.data.post.primary_industry_id];
      $scope.data.post.tag_list = $scope.data.post.tag_list.map(function(tag) { return tag.name; });
      $scope.data.post.seo_keyword_list = $scope.data.post.seo_keyword_list.map(function(seo_keyword) { return seo_keyword.name; });

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

  AddMediaService.initRedactorMediaPlugin();
  ImageFitService.initRedactorImageFitPlugin();

  $scope.redactorOptions = {
    plugins: ['media', 'imageFit', 'inlinestyle'],
    minHeight: 800,
    focus: true,
    buttonSource: true,
    deniedTags: ['html', 'head', 'link', 'body', 'applet'] // Allow script, style
  };

  $scope.isAuthorUser = function(post) {
    if (!post.id || post.author) {
      return true;
    }
    else {
      return false;
    }
  };

  $scope.data.authorIsUser = $scope.isAuthorUser(post);

  if ($state.includes('cortex.posts.*.sections.article')) {
    post.type = 'ArticlePost';
  }
  else if ($state.includes('cortex.posts.*.sections.video')) {
    post.type = 'VideoPost'
  }
  else if ($state.includes('cortex.posts.*.sections.infographic')) {
    post.type = 'InfographicPost'
  }
  else if ($state.includes('cortex.posts.*.sections.promo')) {
    post.type = 'PromoPost'
  }

  $scope.data.post = post;
  $scope.data.categoriesHierarchy = categoriesHierarchy;

  $scope.datepicker = {
    expireAtOpen: false,
    publishAtOpen: false,
    open: function(datepicker) {
      $timeout(function(){
        $scope.datepicker[datepicker] = true;
      });
    }
  };
});
