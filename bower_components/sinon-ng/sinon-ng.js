(function (sinon, angular) {
  'use strict';

  var injector = angular.injector(['ng']),
      $timeout = injector.get('$timeout'),
      $q = injector.get('$q');

  var proto = {
    fulfills: function fulfills(value) {
      this.func = function () {
        return $timeout(function () {
          return value;
        });
      };
      return this.returns($q.when(value));
    },
    rejects: function rejects(value) {
      this.func = function () {
        return $timeout(function () {
          return $q.reject(value);
        });
      };
      return this.returns($q.reject(value));
    }
  };

  sinon.extend(sinon.stub, proto);
  sinon.extend(sinon.behavior, proto);

})(window.sinon, window.angular);
