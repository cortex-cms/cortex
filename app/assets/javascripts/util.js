angular.module('cortex.util', [])

.constant('util', {
  supplant: function (str, obj) {
    return str.replace(
      /\{([^{}]*)\}/g,
      function (a, b) {
        var r = obj[b];
        return typeof r === 'string' || typeof r === 'number' ? r : a;
      }
    );
  },

  randomString: function (length) {
    var chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    var result = '';
    for (var i = 0; i < length; ++i) {
      result += chars[Math.round(Math.random() * (chars.length - 1))];
    }
    return result;
  },

  isEmpty: function (str) {
    return (!str || 0 === str.length);
  }

  // Eventually replace many of these util functions with Underscore-String
})

.factory('hierarchyUtils', function () {
  return {
    flattenTenantHierarchy: function (tenants) {
      var flatten = function (tenants, result) {
        _.each(tenants, function (tenant) {
          result.push(tenant);
          if (tenant.children && tenant.children.length > 0) {
            flatten(tenant.children, result);
          }
        });
      };
      var flattened = [];
      flatten(tenants, flattened);
      return flattened;
    }
  };
})

.filter('totalTenants', function (hierarchyUtils) {
  return function (children) {
    return hierarchyUtils.flattenTenantHierarchy(children).length;
  };
});
