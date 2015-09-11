# sinon-ng

[AngularJS](http://angularjs.org) plugin for [Sinon.JS](http://sinonjs.org).

Not much here at the moment, but if you don't care to setup mocks for `$http` calls, this is for you.

## API

These examples leverage [Mocha](http://visionmedia.github.io/mocha/), [Chai](http://chaijs.com/), and [Chai as Promised](https://github.com/domenic/chai-as-promised/).

### `fulfills()`

Causes a SinonJS stub to return a `$q` promise, fulfilled with the value you specify.  Compatible with the `onCall()` functions.

Example:

```js
it('should not worry and be happy', inject(function($http) {
  var foo = {
      bar: function() {
        return $http.post('somewhere', {stuff: 'things'});
      }
    }, 
    res = {data: 'other stuff'};
    
  sinon.stub(foo, 'bar').fulfills(res);
  
  return expect(foo.bar()).to.eventually.equal(res);
}));
```

### `rejects()`

Causes a SinonJS stub to return a `$q` promise, rejected with the value you specify.  Compatible with the `onCall()` functions.

Example:

```js
it('should go soak its head', inject(function($http) {
  var foo = {
      bar: function() {
        return $http.post('somewhere', {stuff: 'things'});
      }
    }, 
    res = {error: 'oh noes'};
    
  sinon.stub(foo, 'bar').rejects(res);
  
  return expect(foo.bar()).to.eventually.be.rejectedWith(res);
}));
```

## Install

```
bower install sinon-ng
```

## License

MIT

## Author

[Christopher Hiller](http://boneskull.github.io)
