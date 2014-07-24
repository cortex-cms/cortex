angular.module('cortex.states', [
  'ui.router.state',

  'cortex.services.cortex',
  'cortex.templates',

  'cortex.controllers.media.edit',
  'cortex.controllers.media.filters',
  'cortex.controllers.media.grid',
  'cortex.controllers.media.new',
  'cortex.controllers.organizations',
  'cortex.controllers.organizations.manage',

  'cortex.controllers.posts.edit',
  'cortex.controllers.posts.edit.info',
  'cortex.controllers.posts.edit.classify',
  'cortex.controllers.posts.edit.display',
  'cortex.controllers.posts.edit.seo',

  'cortex.controllers.posts.filters',
  'cortex.controllers.posts.grid',
  'cortex.controllers.posts.popup',
  'cortex.controllers.tenants.edit',
  'cortex.controllers.tenants.manage',
  'cortex.controllers.users.edit'
])

.config(function ($stateProvider, $urlRouterProvider) {

  // Catch /admin/media link from breadcrumb
  $urlRouterProvider.when('/media', '/media///');

  $stateProvider
    .state('login', {
      url: '/login',
      templateUrl: 'login',
      data: {pageTitle: 'Login'}
    })

    .state('cortex', {
      abstract: true,
      url: '',
      templateUrl: 'main.html',
      data: {
        ncyBreadcrumbLabel: 'Home'
      }
    })

    // Media

    .state('cortex.media', {
      url: '/media',
      abstract: true,
      template: '<div class="media" ui-view></div>',
      data: {
        ncyBreadcrumbLabel: 'Media',
        ncyBreadcrumbLink: '/media///'
      }
    })

    .state('cortex.media.new', {
      url: '/new',
      templateUrl: 'media/new.html',
      controller: 'MediaNewCtrl',
      data: {
        ncyBreadcrumbLabel: 'Add Media'
      }
    })

    .state('cortex.media.edit', {
      url: '/:mediaId/edit',
      templateUrl: 'media/edit.html',
      controller: 'MediaEditCtrl',
      data: {
        ncyBreadcrumbLabel: 'Edit Media'
      }
    })

    .state('cortex.media.manage', {
      url: '',
      abstract: true,
      templateUrl: 'media/manage.html',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.media.manage.components', {
      url: '/:page/:perPage/:query',
      views: {
        'media-grid': {
          templateUrl: 'media/grid.html',
          controller: 'MediaGridCtrl'
        },
        'media-filters': {
          templateUrl: 'media/filters.html',
          controller: 'MediaFiltersCtrl'
        }
      },
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    // Posts

    .state('cortex.posts', {
      url: '/posts',
      abstract: true,
      template: '<div class="admin-posts" ui-view></div>',
      data: {
        ncyBreadcrumbLabel: 'Posts'
      }
    })

    .state('cortex.posts.new', {
      url: '/new',
      abstract: true,
      templateUrl: 'posts/edit.html',
      controller: 'PostsEditCtrl',
      resolve: {
        post: ['$q', 'cortex', 'currentUser', function($q, cortex, currentUser) {
          var defer = $q.defer();

          var post = new cortex.posts();
          post.body = '';
          post.draft = true;
          post.author = currentUser.full_name;
          post.copyright_owner = post.copyright_owner || "CareerBuilder, LLC";
          post.tag_list = '';

          defer.resolve(post);
          return defer.promise;
        }],
        categoriesHierarchy: ['cortex', function(cortex) {
          return cortex.categories.hierarchy().$promise;
        }],
        filters: ['cortex', function(cortex) {
          return cortex.posts.filters().$promise;
        }],
        currentUserAuthor: ['cortex', 'currentUser', function(cortex, currentUser) {
          return cortex.userAuthor.get({user_id: currentUser.id}).$promise;
        }]
      },
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.new.sections', {
      url: '',
      abstract: true,
      views: {
        'info': {
          templateUrl: 'posts/article/info.html',
          controller: 'PostsEditInfoCtrl'
        },
        'classify': {
          templateUrl: 'posts/article/classify.html',
          controller: 'PostsEditClassifyCtrl'
        },
        'display': {
          templateUrl: 'posts/article/display.html',
          controller: 'PostsEditDisplayCtrl'
        },
        'seo': {
          templateUrl: 'posts/article/seo.html',
          controller: 'PostsEditSeoCtrl'
        }
      }
    })

    .state('cortex.posts.new.sections.article', {
      url: '/article',
      data: {
        ncyBreadcrumbLabel: 'New Post'
      }
    })

    .state('cortex.posts.new.sections.video', {
      url: '/video',
      data: {
        ncyBreadcrumbLabel: 'New Post'
      }
    })

    .state('cortex.posts.new.sections.infographic', {
      url: '/infographic',
      data: {
        ncyBreadcrumbLabel: 'New Post'
      }
    })

    .state('cortex.posts.new.sections.promo', {
      url: '/promo',
      views: {
        'info@cortex.posts.new': {
          templateUrl: 'posts/promo/info.html',
          controller: 'PostsEditInfoCtrl'
        },
        'display@cortex.posts.new': {
          templateUrl: 'posts/promo/display.html',
          controller: 'PostsEditDisplayCtrl'
        },
        'seo@cortex.posts.new': {
          templateUrl: 'posts/promo/seo.html',
          controller: 'PostsEditSeoCtrl'
        }
      },
      data: {
        ncyBreadcrumbLabel: 'New Post'
      }
    })

    .state('cortex.posts.edit', {
      url: '/:postId/edit',
      abstract: true,
      templateUrl: 'posts/edit.html',
      controller: 'PostsEditCtrl',
      resolve: {
        categoriesHierarchy: ['cortex', function(cortex) {
          return cortex.categories.hierarchy().$promise;
        }],
        filters: ['cortex', function(cortex) {
          return cortex.posts.filters().$promise;
        }],
        currentUserAuthor: ['cortex', 'currentUser', function(cortex, currentUser) {
          return cortex.userAuthor.get({user_id: currentUser.id}).$promise;
        }],
        post: ['$stateParams', '$q', 'cortex', function($stateParams, $q, cortex, categoriesHierarchy) {
          var defer = $q.defer();

          cortex.posts.get({id: $stateParams.postId}).$promise
            .then(function(post) {
              if (post.industry) {
                post.industry_id = post.industry.id;
              }

              var selectedCategoryIds = _.map(post.categories, function (c) {
                return c.id;
              });

              _.each(categoriesHierarchy, function (category) {
                _.each(category.children, function (child) {
                  if (_.contains(selectedCategoryIds, child.id)) {
                    child.$selected = true;
                  }
                });
              });

              defer.resolve(post);
            }, function(response) {
              defer.reject(response);
            });

          return defer.promise;
        }]
      },
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.edit.sections', {
      url: '',
      abstract: true,
      views: {
        'info': {
          templateUrl: 'posts/article/info.html',
          controller: 'PostsEditInfoCtrl'
        },
        'classify': {
          templateUrl: 'posts/article/classify.html',
          controller: 'PostsEditClassifyCtrl'
        },
        'display': {
          templateUrl: 'posts/article/display.html',
          controller: 'PostsEditDisplayCtrl'
        },
        'seo': {
          templateUrl: 'posts/article/seo.html',
          controller: 'PostsEditSeoCtrl'
        }
      }
    })

    .state('cortex.posts.edit.sections.article', {
      url: '/article',
      data: {
        ncyBreadcrumbLabel: 'Edit Post'
      }
    })

    .state('cortex.posts.edit.sections.video', {
      url: '/video',
      data: {
        ncyBreadcrumbLabel: 'Edit Post'
      }
    })

    .state('cortex.posts.edit.sections.infographic', {
      url: '/infographic',
      data: {
        ncyBreadcrumbLabel: 'Edit Post'
      }
    })

    .state('cortex.posts.edit.sections.promo', {
      url: '/promo',
      views: {
        'info@cortex.posts.edit': {
          templateUrl: 'posts/promo/info.html'
        },
        'display@cortex.posts.edit': {
          templateUrl: 'posts/promo/display.html'
        },
        'seo@cortex.posts.edit': {
          templateUrl: 'posts/promo/seo.html'
        }
      },
      data: {
        ncyBreadcrumbLabel: 'Edit Post'
      }
    })

    // Posts Edit + Media Popup
    // **********************

    // ** Article/Media Popup (Edit)

    .state('cortex.posts.edit.sections.article.media', {
      url: '/media',
      abstract: true,
      views: {
        'popup@cortex.posts.edit': {
          templateUrl: 'posts/popup.html',
          controller: 'PostsPopupCtrl'
        }
      },
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.edit.sections.article.media.new', {
      url: '/new',
      templateUrl: 'media/new.html',
      controller: 'MediaNewCtrl',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.edit.sections.article.media.edit', {
      url: '/:mediaId/edit',
      templateUrl: 'media/edit.html',
      controller: 'MediaEditCtrl',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.edit.sections.article.media.manage', {
      url: '',
      abstract: true,
      templateUrl: 'media/manage.html',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.edit.sections.article.media.manage.components', {
      url: '/:page/:perPage/:query',
      views: {
        'media-grid': {
          templateUrl: 'media/grid.html',
          controller: 'MediaGridCtrl'
        },
        'media-filters': {
          templateUrl: 'media/filters.html',
          controller: 'MediaFiltersCtrl'
        }
      },
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    // ** Video/Media Popup (Edit)

    .state('cortex.posts.edit.sections.video.media', {
      url: '/media',
      abstract: true,
      views: {
        'popup@cortex.posts.edit': {
          templateUrl: 'posts/popup.html',
          controller: 'PostsPopupCtrl'
        }
      },
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.edit.sections.video.media.new', {
      url: '/new',
      templateUrl: 'media/new.html',
      controller: 'MediaNewCtrl',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.edit.sections.video.media.edit', {
      url: '/:mediaId/edit',
      templateUrl: 'media/edit.html',
      controller: 'MediaEditCtrl',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.edit.sections.video.media.manage', {
      url: '',
      abstract: true,
      templateUrl: 'media/manage.html',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.edit.sections.video.media.manage.components', {
      url: '/:page/:perPage/:query',
      views: {
        'media-grid': {
          templateUrl: 'media/grid.html',
          controller: 'MediaGridCtrl'
        },
        'media-filters': {
          templateUrl: 'media/filters.html',
          controller: 'MediaFiltersCtrl'
        }
      },
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    // ** Infographic/Media Popup (Edit)

    .state('cortex.posts.edit.sections.infographic.media', {
      url: '/media',
      abstract: true,
      views: {
        'popup@cortex.posts.edit': {
          templateUrl: 'posts/popup.html',
          controller: 'PostsPopupCtrl'
        }
      },
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.edit.sections.infographic.media.new', {
      url: '/new',
      templateUrl: 'media/new.html',
      controller: 'MediaNewCtrl',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.edit.sections.infographic.media.edit', {
      url: '/:mediaId/edit',
      templateUrl: 'media/edit.html',
      controller: 'MediaEditCtrl',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.edit.sections.infographic.media.manage', {
      url: '',
      abstract: true,
      templateUrl: 'media/manage.html',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.edit.sections.infographic.media.manage.components', {
      url: '/:page/:perPage/:query',
      views: {
        'media-grid': {
          templateUrl: 'media/grid.html',
          controller: 'MediaGridCtrl'
        },
        'media-filters': {
          templateUrl: 'media/filters.html',
          controller: 'MediaFiltersCtrl'
        }
      },
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    // ** Promo/Media Popup (Edit)

    .state('cortex.posts.edit.sections.promo.media', {
      url: '/media',
      abstract: true,
      views: {
        'popup@cortex.posts.edit': {
          templateUrl: 'posts/popup.html',
          controller: 'PostsPopupCtrl'
        }
      },
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.edit.sections.promo.media.new', {
      url: '/new',
      templateUrl: 'media/new.html',
      controller: 'MediaNewCtrl',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.edit.sections.promo.media.edit', {
      url: '/:mediaId/edit',
      templateUrl: 'media/edit.html',
      controller: 'MediaEditCtrl',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.edit.sections.promo.media.manage', {
      url: '',
      abstract: true,
      templateUrl: 'media/manage.html',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.edit.sections.promo.media.manage.components', {
      url: '/:page/:perPage/:query',
      views: {
        'media-grid': {
          templateUrl: 'media/grid.html',
          controller: 'MediaGridCtrl'
        },
        'media-filters': {
          templateUrl: 'media/filters.html',
          controller: 'MediaFiltersCtrl'
        }
      },
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    // ** Article/Media Popup (New)

    .state('cortex.posts.new.sections.article.media', {
      url: '/media',
      abstract: true,
      views: {
        'popup@cortex.posts.new': {
          templateUrl: 'posts/popup.html',
          controller: 'PostsPopupCtrl'
        }
      },
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.new.sections.article.media.new', {
      url: '/new',
      templateUrl: 'media/new.html',
      controller: 'MediaNewCtrl',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.new.sections.article.media.edit', {
      url: '/:mediaId/edit',
      templateUrl: 'media/edit.html',
      controller: 'MediaEditCtrl',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.new.sections.article.media.manage', {
      url: '',
      abstract: true,
      templateUrl: 'media/manage.html',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.new.sections.article.media.manage.components', {
      url: '/:page/:perPage/:query',
      views: {
        'media-grid': {
          templateUrl: 'media/grid.html',
          controller: 'MediaGridCtrl'
        },
        'media-filters': {
          templateUrl: 'media/filters.html',
          controller: 'MediaFiltersCtrl'
        }
      },
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    // ** Video/Media Popup (New)

    .state('cortex.posts.new.sections.video.media', {
      url: '/media',
      abstract: true,
      views: {
        'popup@cortex.posts.new': {
          templateUrl: 'posts/popup.html',
          controller: 'PostsPopupCtrl'
        }
      },
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.new.sections.video.media.new', {
      url: '/new',
      templateUrl: 'media/new.html',
      controller: 'MediaNewCtrl',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.new.sections.video.media.edit', {
      url: '/:mediaId/edit',
      templateUrl: 'media/edit.html',
      controller: 'MediaEditCtrl',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.new.sections.video.media.manage', {
      url: '',
      abstract: true,
      templateUrl: 'media/manage.html',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.new.sections.video.media.manage.components', {
      url: '/:page/:perPage/:query',
      views: {
        'media-grid': {
          templateUrl: 'media/grid.html',
          controller: 'MediaGridCtrl'
        },
        'media-filters': {
          templateUrl: 'media/filters.html',
          controller: 'MediaFiltersCtrl'
        }
      },
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    // ** Infographic/Media Popup (New)

    .state('cortex.posts.new.sections.infographic.media', {
      url: '/media',
      abstract: true,
      views: {
        'popup@cortex.posts.new': {
          templateUrl: 'posts/popup.html',
          controller: 'PostsPopupCtrl'
        }
      },
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.new.sections.infographic.media.new', {
      url: '/new',
      templateUrl: 'media/new.html',
      controller: 'MediaNewCtrl',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.new.sections.infographic.media.edit', {
      url: '/:mediaId/edit',
      templateUrl: 'media/edit.html',
      controller: 'MediaEditCtrl',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.new.sections.infographic.media.manage', {
      url: '',
      abstract: true,
      templateUrl: 'media/manage.html',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.new.sections.infographic.media.manage.components', {
      url: '/:page/:perPage/:query',
      views: {
        'media-grid': {
          templateUrl: 'media/grid.html',
          controller: 'MediaGridCtrl'
        },
        'media-filters': {
          templateUrl: 'media/filters.html',
          controller: 'MediaFiltersCtrl'
        }
      },
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    // ** Promo/Media Popup (New)

    .state('cortex.posts.new.sections.promo.media', {
      url: '/media',
      abstract: true,
      views: {
        'popup@cortex.posts.new': {
          templateUrl: 'posts/popup.html',
          controller: 'PostsPopupCtrl'
        }
      },
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.new.sections.promo.media.new', {
      url: '/new',
      templateUrl: 'media/new.html',
      controller: 'MediaNewCtrl',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.new.sections.promo.media.edit', {
      url: '/:mediaId/edit',
      templateUrl: 'media/edit.html',
      controller: 'MediaEditCtrl',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.new.sections.promo.media.manage', {
      url: '',
      abstract: true,
      templateUrl: 'media/manage.html',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.new.sections.promo.media.manage.components', {
      url: '/:page/:perPage/:query',
      views: {
        'media-grid': {
          templateUrl: 'media/grid.html',
          controller: 'MediaGridCtrl'
        },
        'media-filters': {
          templateUrl: 'media/filters.html',
          controller: 'MediaFiltersCtrl'
        }
      },
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    // **********************

    .state('cortex.posts.manage', {
      url: '',
      abstract: true,
      templateUrl: 'posts/manage.html',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.posts.manage.components', {
      url: '',
      views: {
        'posts-grid': {
          templateUrl: 'posts/grid.html',
          controller: 'PostsGridCtrl'
        },
        'posts-filters': {
          templateUrl: 'posts/filters.html',
          controller: 'PostsFiltersCtrl'
        }
      },
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    // Tenants

    .state('cortex.organizations', {
      url: '/organizations/:organizationId',
      template: '<ui-view/>',
      abstract: true,
      controller: 'OrganizationsCtrl',
      resolve: {
        organizations: ['cortex', function(cortex) {
          return cortex.tenants.query().$promise;
        }]
      },
      data: {
        ncyBreadcrumbLabel: 'Tenants'
      }
    })

    .state('cortex.organizations.tenants', {
      url: '',
      template: '<ui-view/>',
      abstract: true,
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.organizations.tenants.edit', {
      url: '/tenants/:tenantId/edit',
      templateUrl: 'tenants/edit.html',
      controller: 'EditTenantsCtrl',
      data: {
        ncyBreadcrumbLabel: 'Edit Tenant'
      }
    })

    .state('cortex.organizations.tenants.new', {
      url: '/tenants/new',
      templateUrl: 'tenants/edit.html',
      controller: 'EditTenantsCtrl',
      data: {
        ncyBreadcrumbLabel: 'Add Tenant'
      }
    })

    .state('cortex.organizations.manage', {
      url: '',
      templateUrl: 'organizations/manage.html',
      controller: 'OrganizationsManageCtrl',
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    .state('cortex.organizations.manage.tenants', {
      url: '/tenants/:tenantId',
      views: {
        'tenants-tree': {
          templateUrl: 'tenants/manage.tree.html',
          controller: 'TenantsTreeCtrl'
        },
        'tenants-details': {
          templateUrl: 'tenants/manage.details.html'
        }
      },
      resolve: {
        organization: ['$stateParams', 'cortex', function($stateParams, cortex) {
          return cortex.tenants.get({id: $stateParams.organizationId, include_children: true}).$promise;
        }]
      },
      data: {
        ncyBreadcrumbLabel: false
      }
    })

    // Products

    .state('cortex.products', {
      url: '/products',
      template: 'Applications placeholder',
      data: {
        ncyBreadcrumbLabel: 'Apps/Products'
      }
    })

    // Permissions

    .state('cortex.permissions', {
      url: '/permissions',
      template: 'Permissions placeholder',
      data: {
        ncyBreadcrumbLabel: 'Roles/Permissions'
      }
    })

    .state('cortex.users', {
      url: '/users',
      abstract: true,
      template: '<ui-view/>'
    })

    .state('cortex.users.edit', {
      url: '/:userId',
      templateUrl: 'users/edit.html',
      controller: 'UsersEditCtrl',
      data: {
        ncyBreadcrumbLabel: 'Users/Edit'
      },
      resolve: {
        user: ['$stateParams', 'cortex', function($stateParams, cortex) {
          return cortex.users.get({id: $stateParams.userId});
        }],
        author: ['$stateParams', '$q', 'cortex', function($stateParams, $q, cortex) {
          var defer = $q.defer();

          // Resolve the user's author information or create a new userAuthor resource
          cortex.userAuthor.get({user_id: $stateParams.userId}).$promise
            .then(function(author) {
              author.user_id = $stateParams.userId;
              defer.resolve(author);
            }, function(response) {
              if (response.status === 404) {
                defer.resolve(new cortex.userAuthor({user_id: $stateParams.userId}));
              } else {
                defer.reject(response);
              }
            });

          return defer.promise;
        }]
      }
    });
});
