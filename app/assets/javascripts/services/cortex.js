angular.module('cortex.services.cortex', [
  'cortex.settings',
  'cortex.resources'
])

.factory('cortex', function($rootScope, $http, cortexResource, paginatedResource, settings) {

  var categories = cortexResource('/categories/:id', {id: '@id'}, {
    hierarchy: {method: 'GET', url: settings.cortex_base_url + '/categories/:id/hierarchy', isArray: true}
  });

  var posts = paginatedResource('/posts/:id', {id: '@id'}, {
    feed:    {method: 'GET', params: {id: 'feed'}, isArray: true, paginated: true},
    tags:    {method: 'GET', params: {id: 'tags'}, isArray: true},
    search:  {method: 'GET', params: { }, isArray: true, paginated: true},
    filters: {method: 'GET', params: {id: 'filters'} }
  });

  var media = paginatedResource('/media/:id', {id: '@id'}, {
    search: {method: 'GET', params: {id: 'search'}, isArray: true, paginated: true}
  });

  var tenants = cortexResource('/tenants/:id', {id: '@id'});

  var users = cortexResource('/users/:id', {id: '@id'}, {
    me: {method: 'GET', params: {id: 'me'}}
  });

  var occupations = cortexResource('/occupations/:id', {id: '@id', isArray: true}, {
    industries: {method: 'GET', params: {id: 'industries'}, isArray: true}
  });

  return {
    categories:  categories,
    posts:       posts,
    media:       media,
    tenants:     tenants,
    users:       users,
    occupations: occupations
  };
});
