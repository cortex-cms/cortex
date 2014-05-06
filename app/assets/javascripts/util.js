var module = angular.module('cortex.util', []);

module.constant('util', {
    supplant: function(str, obj) {
      return str.replace(
        /\{([^{}]*)\}/g,
        function (a, b) {
          var r = obj[b];
          return typeof r === 'string' || typeof r === 'number' ? r : a;
        }
      );
    },

    randomString: function(length) {
      var chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
      var result = '';
      for (var i = 0; i < length; ++i) {
        result += chars[Math.round(Math.random() * (chars.length - 1))];
      }
      return result;
    },

    insert: function(str, idx, substr) {
        return str.substr(0, idx) + substr + str.substr(idx);
    }
  }
);
