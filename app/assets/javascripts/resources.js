angular.module('cortex.resources', [
  'ngResource',
  'cortex.settings',
  'cortex.session'
])

.constant('defaultActions', {
  'get':    {method: 'GET'},
  'save':   {method: 'POST'},
  'query':  {method: 'GET', isArray: true},
  'remove': {method: 'DELETE'},
  'delete': {method: 'DELETE'}
})

.constant('updateCreateActions', {
  update: {method: 'PUT', inArray: false},
  create: {method: 'POST'}
})

.factory('cortexResource', function($resource, settings, currentUser, updateCreateActions) {
  return function (url, params, actions) {
    actions = angular.extend(updateCreateActions, actions);

    var resource = $resource(settings.cortex_base_url + url, params, actions);

    resource.prototype.$save = function(params, success, error) {
        return this.id ? this.$update(params, success, error) : this.$create(params, success, error);
    };
    return resource;
  };
})

.factory('paginatedResource', function(cortexResource, defaultActions) {
  var forEach    = angular.forEach,
    extend     = angular.extend,
    isFunction = angular.isFunction;

  return function(url, params, actions) {
    actions = extend(actions, defaultActions);

    var resource = cortexResource(url, params, actions);

    forEach(actions, function(action, name) {
      // If action is paginated ($query() or pagination == true in action config)

      if (/^(QUERY)$/i.test(name) || action.paginated) {

        // Wrap action function in pagination handler
        resource[name + 'Paged'] = function(params, success, error) {
          if (isFunction(params)) {
            error = success; success = params; params = {};
          }

          var wrappedSuccess = function(data, headers) {
            var pagination;
            var range = headers('X-Total');
            if (range) {

              var start    = (headers('X-Page') - 1) * headers('X-Per-Page');
              var end      = parseInt(headers('X-Per-Page')) + start;
              var per_page = headers('X-Per-Page');
              var total    = headers('X-Total');
              var page     = headers('X-Page') || 1;

              pagination = {
                page: page,
                pages: parseInt(total / per_page) + 1,
                start: start,
                end: end,
                per_page: per_page,
                total: total
              };
              debugger
            }

            // Call original callback
            if (isFunction(success)) {
              success(data, headers, pagination);
            }

          };

          return resource[name](params, wrappedSuccess, error);
        };
      }
    });

    return resource;
  };
});
