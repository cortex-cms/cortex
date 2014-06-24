mock = (function() {
  'use strict';

  // A primitive mock factory, returns a function that accepts an object to override properties
  //
  //   Example mock construction:
  //   var userMock = factory({name: 'Fred', id: 1});
  //
  //   Example mock use:
  //   var fred   = userMock();                        // returns {name: 'Fred', id: 1}
  //   var jackie = userMock({name: 'Jackie', id: 2}); // returns {name: 'Jackie', id: 2}
  var factory = function(defaultMock) {
    return function(properties) {
      var mock = defaultMock;
      if (typeof(properties) === 'Object') {
        for (var k in properties) {
          defaultMock[k] = properties[k];
        }
      }
      return mock;
    }
  };

  var basicGon = {
    current_user: null,
    settings: {
      cortex_base_url: ''
    }
  };

  return {
    gon: factory(basicGon)
  };

})();
