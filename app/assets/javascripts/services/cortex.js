angular.module('cortex.services.cortex', [
  'cortex.settings',
  'cortex.resources'
])

.factory('cortex', function($rootScope, $http, cortexResource, paginatedResource, settings) {

  var categories = cortexResource('/categories/:id', {id: '@id'}, {
    hierarchy: {
      method: 'GET',
      url:     settings.cortex_base_url + '/categories/:id/hierarchy',
      isArray: true
    }
  });

  var locales = paginatedResource('/localizations/:localization_id/locales/:locale_name', {locale_name: '@locale_name'}, {
    search: {method: 'GET', params: {}, isArray: true, paginated: true}
  });

  var localizations = paginatedResource('/localizations/:id', {id: '@id'}, {
    search: {method: 'GET', params: {}, isArray: true, paginated: true}
  });

  var posts = paginatedResource('/posts/:id', {id: '@id'}, {
    feed:    {method: 'GET', params: {id: 'feed'}, isArray: true, paginated: true},
    tags:    {method: 'GET', params: {id: 'tags'}, isArray: true},
    search:  {method: 'GET', params: { }, isArray: true, paginated: true},
    filters: {method: 'GET', params: {id: 'filters'} }
  });

  var media = paginatedResource('/media/:id', {id: '@id'}, {
    tags:   {method: 'GET', params: {id: 'tags'}, isArray: true},
    search: {method: 'GET', params: { }, isArray: true, paginated: true}
  });

  var tenants = cortexResource('/tenants/:id', {id: '@id'});

  var userAuthor = cortexResource('/users/:user_id/author', {user_id: '@user_id'});

  var users = cortexResource('/users/:id', {id: '@id'}, {
    me: {method: 'GET', params: {id: 'me'}}
  });

  var occupations = cortexResource('/occupations/:id', {id: '@id', isArray: true}, {
    industries: {method: 'GET', params: {id: 'industries'}, isArray: true}
  });

  var applications = paginatedResource('/applications/:id', {id: '@id', isArray: true}, {
    search: {method: 'GET', params: { }, isArray: true, paginated: true}
  });

  return {
    categories:    categories,
    locales:       locales,
    localizations: localizations,
    posts:         posts,
    media:         media,
    tenants:       tenants,
    users:         users,
    userAuthor:    userAuthor,
    occupations:   occupations,
    applications:  applications
  };
});
