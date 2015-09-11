/*! angular-debaser - v0.3.2 - 2014-08-07
* https://github.com/decipherinc/angular-debaser
* Copyright (c) 2014 Decipher, Inc.; Licensed MIT */

(function (window, angular) {
  'use strict';

  /**
   * @typedef {Array.<String>} Annotation
   * @ignore
   * @description Annotation for AngularJS factories.
   */

  /**
   * @external angular
   * @ignore
   * @see {@link http://angularjs.org}
   */

  /**
   * @summary Options, and their defaults, which you can pass into {@link debaser window.debaser()}.
   * @description Default options
   * @typedef {Object} DebaserOptions
   * @property {boolean} [debugEnabled=false] Enable debug log messages?
   * @property {boolean} [autoScope=true] Enable auto-scope functionality when using {@link ng.$controller}?
   * @property {boolean} [skipConfigs=true] Enable stubbing of `config()` blocks?
   * @property {string} [defaultName=__default__] Default name of default Debaser instance; useless
   * @global
   */
  var DEFAULT_OPTS = {
    debugEnabled: false,
    autoScope: true,
    skipConfigs: true,
    defaultName: '__default__'
  };

  /**
   * Attaches {@link debaser} and {@link debase} to the `window` object.
   * Registers `setup()`/`teardown()` or `beforeEach()`/`afterEach()` functions to retrieve the current spec.
   */
  var install = function install() {

    window.debaser = debaser;
    window.debase = debase;

    // TODO document these
    (window.beforeEach || window.setup)(function () {
      debaser.$$currentSpec = this;
    });

    (window.afterEach || window.teardown)(function () {
      delete debaser.$$currentSpec;
    });

  };

  /**
   * @description Whether or not we are currently running in a spec.
   * @returns {boolean}
   */
  var hasCurrentSpec = function hasCurrentSpec() {
    return !!debaser.$$currentSpec;
  };

  /**
   * @alias window.debaser
   * @summary Provides a {@link Debaser} object with which you can stub dependencies easily.
   * @description The object by this method exposes {@link Action actions}, which are chainable.  Each action "queues up" something to be stubbed, be that a module, function, object, or whatever.  When you have queued all your actions, execute {@link Debaser#debase debase()} and the stubs will be provided.
   * @param {(String|Object)} [name=DebaserOptions.name] Optional name of Debaser.  Only useful if using
   * multiple instances.  If omitted, this is considered the `opts` parameter.
   * @param {DebaserOptions} [options={}] Options to modify angular-debaser's behavior; see {@link DebaserOptions}.
   * @example
   *
   * // Defaults
   * var d = debaser({
   *  debugEnabled: false,
   *  autoScope: true
   *  skipConfigs: true
   * });
   *
   * // Named
   * var d = debaser('foo', {
   *  debugEnabled: false,
   *  autoScope: true
   *  skipConfigs: true
   * });
   *
   * @returns {Debaser}
   * @global
   * @public
   * @tutorial donny-developer
   */
  var debaser = function debaser(name, options) {
    var debaserSetup,
      defaultName = DEFAULT_OPTS.defaultName,
      injector,
      instance,
      opts,
      Debaser;

    // setup args
    if (angular.isObject(name)) {
      opts = name;
      name = null;
    } else {
      opts = options;
    }

    opts = opts || {};
    debaserSetup = configure(opts);

    // bootstrap the debaserSetup and decipher.debaser module, so we can get to the debaserFactory.
    angular.mock.module(debaserSetup, 'decipher.debaser');

    // if we are not given a name and the default instance exists, return it so we don't re-instantiate.
    // eliminate debaser.__globalInstance TODO why?
    if (!name && hasInstance(defaultName)) {
      debaser.__globalInstance = null;
      return getInstance(defaultName);
    }

    // injector to retrieve Debaser class.
    injector = angular.injector(['ng', debaserSetup, 'decipher.debaser']);
    //noinspection JSUnusedAssignment
    Debaser = injector.get('debaserDebaser');

    // init new Debaser instance or get existing if given name.  eliminate debaser.__globalInstance
    // since it's no longer applicable.
    if (name) {
      if (!hasInstance(name)) {
        debaser.__debasers[name] = new Debaser(name);
      }
      debaser.__globalInstance = null;
      return getInstance(name);
    }

    // (this is a new Debaser with the default name)
    instance = new Debaser();

    // if we're not in a beforeEach() then we're not in a spec.  call this the global, default instance.
    debaser.__globalInstance = !hasCurrentSpec() ? instance : null;

    return instance;
  };

  /**
   * @description Provides an anonymous AngularJS module to set up some initial values before {@link module:decipher.debaser} is bootstrapped.
   * @param {DebaserOptions} [options] Override {@link DebaserOptions} with this object.
   * @returns {function}
   */
  var configure = function configure(options) {
    /**
     * @description
     * Provides two constants, `debaserOptions`, which is set to a {@link DebaserOptions}
     * object when calling {@link debaser}; and `decipher.debaser.__runConfig` which is internal data
     * to be used when calling {@link debase} or {@link Debaser#debase}.
     * @param {auto.$provide} $provide {@link https://code.angularjs.org/1.2.20/docs/api/auto/service/$provide.html|auto.$provide docs}
     * @property {Annotation} $inject
     */
    var debaserSetup = function debaserSetup($provide) {
      $provide.constant('debaserOptions',
        angular.extend({}, DEFAULT_OPTS, options));
      $provide.constant('debaserRunConfig', runConfig);
    };
    debaserSetup.$inject = ['$provide'];
    return debaserSetup;
  };

  /**
   * @description Retrieve an existing Debaser instance by name.
   * @param {string} name Name of instance
   * @returns {Debaser}
   */
  var getInstance = function getInstance(name) {
    return debaser.__debasers[name];
  };

  /**
   * @description Whether or not an instance with name exists.
   * @param {string} name Name of instance
   * @returns {boolean}
   */
  var hasInstance = function hasInstance(name) {
    return !!getInstance(name);
  };

  /**
   * @description Mapping of {@link Debaser#name}s to {@link Debaser} instances, for potential retrieval later.  **Exposed for unit testing.**
   * @type {Object.<String,Debaser>}
   * @private
   */
  debaser.__debasers = {};

  /**
   * @description Run configurations.  Mapping of {@link Config#_id} to {@link Config} objects. **Exposed for unit testing**
   * @todo test
   * @type {Object.<String,Config>}
   * @private
  */
  var runConfig = debaser.__runConfig = {};

  /**
   * @description Default instance if we are not running in a spec; presumably created in a `before()` block.  **Exposed for unit testing**
   * @type {?Debaser}
   * @todo test
   * @private
   */
  debaser.__globalInstance = null;

  /**
   * @alias window.debase
   * @summary Shortcut to the {@link Debaser#debase debase} method of the default {@link Debaser} instance.
   * @description Convenience method.  Retrieves the default {@link Debaser} instance (whatever that may be) and runs its {@link Debaser#debase debase()} method. 
   * @example
   *
   * before(function() {
   *   debaser()
   *     .func('foo')
   *     .object('bar')
   * });
   *
   * beforeEach(debase);
   *
   * // above equivalent to:
   *
   * var d;
   * before(function() {
   *   d = debaser()
   *     .func('foo')
   *     .object('bar')
   * });
   *
   * beforeEach(function() {
   *   d.debase();
   * });
   * @returns {(function|Debaser)}
   * @param {string} [name] Name of {@link Debaser} instance to call {@link Debaser#debase} upon.
   * @global
   * @public
   */
  var debase = function debase(name) {
    var defaultName = DEFAULT_OPTS.defaultName,

      /**
       * @description Calls {@link Debaser#debase} with proper persistance options.  Unlike {@link Debaser#debase}, will return a {@link Debaser} instance.
       * @memberof globalHelpers
       * @function callDebase
       * @returns {Debaser}
       * @throws Invalid {@link Debaser} name
       * @throws If {@link debaser} was never called
       */
      callDebase = function callDebase() {
        var d;

        if (!name || !angular.isString(name)) {
          if (!hasInstance(defaultName)) {
            if (debaser.__globalInstance) {
              return debaser.__globalInstance.debase({persist: true});
            }
            throw new Error('debaser: no Debaser initialized!');
          }
          name = defaultName;
        }
        else if (!hasInstance(name)) {
          throw new Error('debaser: cannot find Debaser instance with name "' + name + '"');
        }
        d = getInstance(name);
        // TODO not sure if persist value is correct.
        d.debase({
          persist: name !== defaultName
        });
        return d;
      };

    return hasCurrentSpec() ? callDebase() : callDebase;
  };

  install();

  /* global runConfig */

  /**
   * @description Main module for angular-debaser.  You are unlikely to interface with this module directly.  See {@link debaser} to get started.
   */
  angular.module('decipher.debaser', [])

  /**
   * @name debaserRunConfig
   * @memberof module:decipher.debaser
   * @borrows debaser.__runConfig
   */
    .constant('debaserRunConfig', runConfig)
    .config(['debaserOptions', '$logProvider', '$provide',
      function config(options, $logProvider, $provide) {
        // older versions of angular-mocks do not implement this function.
        if (angular.isFunction($logProvider.debugEnabled)) {
          $logProvider.debugEnabled(options.debugEnabled);
        }
        // likewise, maybe no debug() either
        $provide.decorator('$log', ['$delegate', function ($delegate) {
          $delegate.debug = $delegate.debug || options.debugEnabled ? $delegate.log : angular.noop;
          return $delegate;
        }]);
      }
    ]);

  angular.module('decipher.debaser')
    .factory('debaserLoadAction', function loadActionFactory() {

    /**
     * @description Creates a new Action object.
     * @param {object} action Raw action object
     * @param {function} [action.callback=angular.noop] Function to call with the return value of the main Function to call
     * @param {object} [action.object] Object containing main Function to call
     * @param {function} action.func Main Function to call
     * @param {object} [action.context=null] Context to call main Function with
     * @param {Array} [action.args=[]] Arguments to function
     * @constructor
     * @ignore
     * @memberof loadAction
     */
    var Action = function Action(action) {
      angular.extend(this, action);
      this.callback = this.callback || angular.noop;
      this.context = this.context || null;
    };

    Action.prototype.assemble = function assemble() {
      /**
       * @description Executes an assembled function
       * @memberof! Action#assemble
       * @inner
       */
      return angular.bind(this, function action() {
        this.callback(!this.object ? this.func.apply(this.context, this.args) :
          this.object[this.func].apply(this.context, this.args));
      });
    };

    /**
     * @description Accepts a {@link Config} object, constructs and returns {@link Action} instances from its `actions` property
     * @constructs Action
     * @private
     */
    return function loadAction(cfg) {
      return cfg.actions.map(function (action) {
        return new Action(action);
      });
    };
  });

  angular.module('decipher.debaser').factory('debaserAspect',
    ['debaserSuperpowers', 'debaserBehavior',
      function aspectFactory(superpowers, Behavior) {

        var Aspect = function Aspect(name, parent) {
          this.name = name;
          this.parent = parent;
          this._id = Aspect._id++;
        };

        Aspect._id = 0;

        Aspect._DEFAULT_NAME = 'base';

        Object.defineProperties(Aspect.prototype, {
          name: {
            get: function getName() {
              return this._name;
            },
            set: function setName(name) {
              this._dirty = this._isDirty(name, '_name');
              this._name = name || Aspect._DEFAULT_NAME;
            }
          },
          parent: {
            get: function getParent() {
              return this._parent;
            },
            set: function setParent(parent) {
              this._dirty = this._isDirty(parent, '_parent');
              this._parent = parent;
            }
          },
          proto: {
            get: function getProto() {
              var dirty = this._dirty;
              if (!this._proto || dirty) {
                this._initProto();
              }
              this._dirty = false;
              return this._proto;
            },
            set: function setProto(proto) {
              this._proto = proto;
            }
          },
          behavior: {
            get: function getBehavior() {
              var dirty = this._dirty;
              if (!this._behavior || dirty) {
                this._initBehavior();
              }
              this._dirty = false;
              return this._behavior;
            },
            set: function setBehavior(behavior) {
              this._behavior = behavior;
            }
          },
          config: {
            get: function getConfig() {
              return this.behavior.config;
            },
            set: function setConfig(config) {
              this.behavior.config = config;
            }
          }
        });

        Aspect.prototype._initProto = function _initProto() {
          var o;
          if (this._proto && !this._dirty) {
            return;
          }
          o = {};
          if (this.parent) {
            angular.extend(o, this.parent.proto);
          }
          angular.forEach(superpowers, function (fn, name) {
            if (name.charAt(0) !== '$' &&
              fn.$aspect.indexOf(this._name) !== -1) {
              o[name] = this.createProxy(fn, name);
            }
          }, this);
          this._proto = o;
        };

        Aspect.prototype._initBehavior = function _initBehavior() {
          if (this._behavior && !this._dirty) {
            return;
          }
          this._behavior = new Behavior(angular.extend(this._behavior || {},
              this.parent && this.parent.isAspectOf(this.name) &&
              this.parent.behavior), this.name);
        };

        Aspect.prototype.flush = function flush() {
          return this.behavior.flush();
        };

        Aspect.prototype._isDirty = function _isDirty(value, prop) {
          return (value && value !== this[prop]) || (!value && this[prop]);
        };

        Aspect.prototype.createProxy = function createProxy(fn, name) {
          var proxy;
          /**
           * @this Debaser
           * @returns {Debaser|*}
           * @todo trim fat
           */
          proxy = function proxy() {
            var current_aspect = this.$$aspect,
                inherits = current_aspect.isAspectOf(name),
                retval = this,
                aspect,
                result;

            if (!inherits && current_aspect.name !== 'base') {
              this.$enqueue();
            }
            aspect = this.$aspect(fn.$name || name);
            result = fn.apply(aspect.config, arguments);

            if (angular.isArray(result)) {
              aspect.behavior.enqueue(result);
            }
            else if (result) {
              retval = result;
            }
            return retval;
          };
          return proxy;
        };
        Aspect.prototype.createProxy.cache = {};

        Aspect.prototype.isAspectOf = function isAspectOf(name) {
          return name !== 'base' && superpowers[name] &&
            superpowers[name].$aspect.indexOf(this.name) !== -1;
        };

        return Aspect;
      }
    ]);

  angular.module('decipher.debaser').factory('debaserBehavior',
    ['debaserConfig', function $behaviorFactory(Config) {
      var Behavior = function Behavior(o, aspect_name) {
        angular.extend(this, o);
        this._aspect_name = aspect_name;
        this._id = Behavior._id++;
      };

      Behavior._id = 0;

      Behavior.prototype.enqueue = function enqueue(calls) {
        this.queue.push.apply(this.queue, calls);
      };

      Behavior.prototype.flush = function flush() {
        return this.queue.map(function (action) {
          return action.assemble();
        });
      };

      Object.defineProperties(Behavior.prototype, {
        queue: {
          get: function getQueue() {
            if (!this._queue) {
              this._queue = [];
            }
            return this._queue;
          },
          set: function setQueue(queue) {
            this._queue = queue || [];
          }
        },
        config: {
          get: function getConfig() {
            if (!this._config) {
              this._config = new Config(this._aspect_name);
            }
            return this._config;
          },
          set: function setConfig(config) {
            this._config = config || new Config(this._aspect_name);
          }
        }
      });

      return Behavior;
    }]);

  angular.module('decipher.debaser').factory('debaserConfig',
    function configFactory() {

      var bind = angular.bind;
      
      /**
       * @param {(object|string)} o Raw {@link Behavior} configuration object, or {@link Aspect} name
       * @class
       * @param {string} [aspect_name] Name of {@link Aspect} this configuration belongs to
       */
      var Config = function Config(o, aspect_name) {
        if (angular.isString(o)) {
          aspect_name = o;
        }
        else {
          angular.extend(this, o);
        }
        this._aspect_name = aspect_name;
        this._callbacks = [];
        this._cb_idx = 0;
        this._id = Config._id++;
        this.actions = this.actions || [];
      };

      Config._id = 0;

      Config.prototype.addAction = function addAction(opts) {
        if (!opts) {
          throw new Error('$debaser: addCall() expects call options');
        }
        opts.callback = opts.callback || this.runner();
        opts.context =
          angular.isDefined(opts.context) ? opts.context : opts.object || null;
        this.actions.push(opts);
      };

      Config.prototype.next = function next() {
        if (this._callbacks[this._cb_idx]) {
          this._callbacks[this._cb_idx++].apply(this, arguments);
        } else {
          this.done();
        }
      };

      Config.prototype.done = function done() {
        this._cb_idx = 0;
      };

      Config.prototype.chain = function chain(fn) {
        this._callbacks.push(bind(this, function debaserCallbackProxy() {
          this.next(fn.apply(this, arguments));
        }));
      };

      Config.prototype.runner = function runner() {
        return bind(this, function run() {
          this.next.apply(this, arguments);
        });
      };

      Config.prototype.isChained = function isChained() {
        return !!this._callbacks.length;
      };

      return Config;

    });

  angular.module('decipher.debaser').factory('debaserDebaser',
    ['$log', 'debaserAspect', 'debaserOptions',
      function debaserFactory($log, Aspect, options) {

        var defaultName = options.defaultName;


        /**
         * @description Provides an object with which you can stub AngularJS dependencies.  Do not attempt to instantiate this class directly; use the {@link debaser} function instead.
         * @public
         * @mixes base
         * @global
         * @param {string} [name=__default__] Name of Debaser instance
         * @class
         */
        var Debaser = function Debaser(name) {
          if (!angular.isString(name)) {
            name = options.defaultName;
          }
          this.$name = name;
          this.$queue = [];
          this.$aspect('base');
          if (name !== defaultName) {
            $log.debug('$debaser: created Debaser instance with name "' + name + '"');
          } else {
            $log.debug('$debaser: created singleton Debaser instance');
          }
        };

        Debaser.prototype.$aspect = function $aspect(name) {
          var current_aspect = this.$$aspect,
            aspect,
            proto;
          if (angular.isUndefined(name)) {
            name = current_aspect.name;
          }
          if (current_aspect) {
            proto = current_aspect.proto;
            Object.keys(proto).forEach(function (name) {
              delete this[name];
            }, this);
          }
          aspect = new Aspect(name, current_aspect);
          angular.extend(this, aspect.proto);
          this.$$aspect = aspect;
          return aspect;
        };

        Debaser.prototype.$enqueue = function $enqueue() {
          var current_aspect = this.$$aspect;
          if (current_aspect) {
            this.$queue.push.apply(this.$queue, current_aspect.flush());
          }
        };

        Debaser.autoScopeProvider = function ($provide) {
          $provide.decorator('$controller',
            ['$rootScope', '$delegate', function ($rootScope, $delegate) {
              return function (name, locals) {
                locals = locals || {};
                if (!locals.$scope) {
                  locals.$scope = $rootScope.$new();
                }
                $delegate(name, locals);
                return locals.$scope;
              };
            }]);
        };
        Debaser.autoScopeProvider.$inject = ['$provide'];

        /**
         * @description All previously queued stubs will be installed upon execution of this method.
         * @param {Object} [opts] Options
         * @param {boolean} [opts.persist=false] If true, retain the queue.  Only used in a non-spec context; {@link debase window.debase} can call it with this option.  You probably don't want to specify this yourself.
         * @returns undefined
         */
        Debaser.prototype.debase = function debase(opts) {
          opts = opts || {};
          this.$enqueue();
          this.$queue.forEach(function (fn) {
            fn();
          });
          if (!opts.persist) {
            this.$queue = [];
          }
          this.$aspect('base');
          if (options.autoScope) {
            angular.mock.module(Debaser.autoScopeProvider);
          }
        };

        return Debaser;
      }]);


  /**
   * @todo split me up
   */
  angular.module('decipher.debaser').factory('debaserSuperpowers',
    ['debaserLoadAction', '$window', 'debaserRunConfig', '$log',
      'debaserOptions',
      function superpowersFactory(loadAction, $window, $runConfig, $log, options) {

        /**
         * @external sinon.stub
         * @description A stub function.  (Almost) all functions available to Sinon.JS stubs.
         * @see http://sinonjs.org/docs/#stubs
         * @mixin sinon.stub
         */

        /**
         * @external sinon.Stub
         * @description 
         * A Stub object.  Returned when using an `*onCall*` method, instead of a {@link sinon.stub stub}.  In this context, use {@link sinon.Stub.end end()} to return to a {@link Debaser} instance. 
         * > The `create()`, `resetBehavior()` and `isPresent()` functions of the Sinon.JS "stub" API are not used.  If someone needs these, please {@link https://github.com/decipherinc/angular-debaser/issues/ create an issue} and provide a use case.
         * @mixin sinon.Stub
         */
        
        /**
         * @namespace base
         * @mixin
         */

        /**
         * @namespace module
         * @memberof base
         * @mixin
         * @mixes base.object
         */

        /**
         * @namespace func
         * @memberof base
         * @mixin
         * @mixes sinon.stub
         */
        
        /**
         * @namespace object
         * @memberof base
         * @mixin       
         */

        /**
         * @namespace withObject
         * @memberof base.module
         * @mixes base.object
         * @mixin
         */
        
        /**
         * @namespace withFunc
         * @memberof base.module
         * @mixes base.func
         * @mixin
         */

        /**
         * @typedef {function} Action
         * @summary A method (on a {@link Debaser} instance) which tells angular-debaser to provide some object, method, function, etc.
         * @description These functions will always return {@link Debaser} instances, however, the mixins used will change.  The "root" mixin is the {@link base} mixin.  All other mixins "inherit" from this one, meaning the {@link base} methods *will always be available*.
         * @example
         * debaser
         *   .object('Foo') // we are now in the `base.object` mixin.
         *   .withFunc('bar') // we are now in the `base.withFunc` mixin.
         *   // however, since these mixins are inherited, we always have access to 
         *   // method `object`, which is on the `base` mixin.
         *   .object('Baz')
         *   .debase(); // go!
         *   // `Foo` and `Baz` are now injectable; `Foo` has a static function `bar`
         *   
         */
          
        var sinon = $window.sinon,
            SINON_EXCLUDE = [
              'create',
              'resetBehavior',
              'isPresent'
            ],
            
            bind = angular.bind,

            // better way to do this?
            isSinon = function isSinon(value) {
              return value.displayName === 'stub' ||
                value.displayName === 'spy';
            },

            debaserConstantCallback = function debaserConstantCallback(module) {
              if (this.name && this.stub && module && module.constant) {
                return module.constant(this.name, this.stub);
              }
            },

            module,
            withDep,
            withDeps,
            func,
            object,
            withFunc,
            withObject;

        /**
         * @memberof base
         * @instance
         * @description Stubs a module, or bootstraps an existing module.    
         * @param {string} name Module name to bootstrap/stub.
         * @param {Array<String>} [deps] Any dependencies of this module.
         * @returns {base.module}
         * @see Action
         */
        module = function module(name, deps) {
          var real_module, i;
          if (!name) {
            name = 'dummy-' + module.$id++;
          }
          if (!angular.isString(name)) {
            throw new Error('$debaser: module() expects a string');
          }
          this.module = name;
          this.module_dependencies = [];
          if (deps) {
            if (!angular.isArray(deps)) {
              throw new Error('$debaser: module() expects array or undefined as second parameter');
            }
            superpowers.withDeps.call(this, deps);
          }
          try {
            real_module = angular.module(name);
            if (options.skipConfigs && real_module) {
              i = real_module._invokeQueue.length;
              while (i--) {
                if (real_module._invokeQueue[i][0] === '$injector' &&
                  real_module._invokeQueue[i][1] === 'invoke') {
                  real_module._invokeQueue.splice(i, 1);
                }
              }
            }
          }
          catch (e) {
          }
          this.addAction({
            object: angular,
            func: 'module',
            args: !real_module ? [this.module, this.module_dependencies] : [this.module]
          });
          this.addAction({
            object: angular.mock,
            func: 'module',
            args: [this.module]
          });
          return loadAction(this);
        };
        module.$aspect = ['base'];
        module.$id = 0;

        /**
         * @description Adds dependencies to the current module.  Potentially useful if you have a dependency chain `A -> B -> C` and you wish to stub `B` but not `A` or `C`.
         * @param {...string} dep Module dependency
         * @memberof base.module
         * @instance
         * @returns {base.module}
         * @see Action
         */
        withDep = function withDep(dep) {
          if (!arguments.length) {
            return $log.debug('$debaser: ignoring empty call to withDep()');
          }
          Array.prototype.slice.call(arguments).forEach(function (arg) {
            if (!angular.isString(arg)) {
              throw new Error('$debaser: withDep() expects one or more strings');
            }
          });
          this.module_dependencies.push.apply(this.module_dependencies,
            arguments);
        };
        withDep.$aspect = ['module'];

        /**
         * @description Like {@link base.module.withDep withDep}, but accepts an array instead.
         * @param {Array<String>} arr Array of module dependencies
         * @memberof base.module
         * @instance
         * @returns {base.module}
         * @see Action
         */
        withDeps = function withDeps(arr) {
          if (!arr) {
            return $log.debug('$debaser: ignoring empty call to withDeps()');
          }
          if (!angular.isArray(arr)) {
            throw new Error('$debaser: withDeps() expects an array');
          }
          withDep.apply(this, arr);
        };
        withDeps.$aspect = ['module'];

        /**
         * @description Creates an injectable function.
         * @param {string} name Name of injectable
         * @memberof base
         * @instance
         * @returns {base.func}
         * @see Action
         */
        func = function func(name) {
          var args = Array.prototype.slice.call(arguments, 1);
          if (!name) {
            return $log.debug('$debaser: ignoring empty call to func()');
          }
          if (!angular.isString(name)) {
            throw new Error('$debaser: func() expects a name');
          }
          this.func = sinon && sinon.stub ? sinon.stub.apply(sinon, args) :
            function debaserStub() {
            };
          return object.call(this, name, this.func);
        };
        func.$aspect = ['base'];

        /**
         * @description Creates an injectable object.
         * @param {string} name Name of injectable
         * @param {Object} [base] If supplied, will inject this object instead.  If {@link http://sinonjs.org Sinon.JS) is present, the object's functions will be spied upon.
         * @memberof base
         * @instance
         * @returns {base.object}
         * @see Action
         */      
        object = function object(name, base) {
          if (!name) {
            return $log.debug('$debaser: ignoring empty call to object()');
          }
          if (!angular.isString(name)) {
            throw new Error('$debaser: object() expects a name');
          }
          if (base && !angular.isFunction(base) && !angular.isObject(base)) {
            throw new Error('$debaser: object() second param should be an ' +
              'Object or undefined');
          }
          if (!this.stub) {
            if (!angular.isObject(base) && !angular.isFunction(base)) {
              base = {};
            }
            if (angular.isObject(base)) {
              this.stub =
                  sinon && sinon.stub && !isSinon(base) ? sinon.stub(base) :
                base;
            } else {
              this.stub = base;
            }
          }
          if (!this.isChained()) {
            this.name = name;
            this.component = 'value';
            this.provider = function provider($provide, $config) {
              var cfg = $config[provider._id];
              $provide[cfg.component](cfg.name, cfg.stub);
            };
            // angularjs hates to inject identical functions.
            // this makes them no longer identical.
            this.provider.toString = bind(this, function toString() {
              return 'debaserProvider-' + this._id.toString();
            });
            this.provider._id = this._id;
            this.provider.$inject = ['$provide', 'debaserRunConfig'];
            this.addAction(
              {
                object: angular.mock,
                func: 'module',
                args: [this.provider]
              }
            );
            $runConfig[this._id] = this;
            return loadAction(this);
          }
        };
        object.$aspect = ['base'];

        /**
         * @description Provides a function on the object, or injectable function on the module.  If used in a module context, then provides a constant.  If {@link http://sinonjs.org Sinon.JS} is present, 
         * @memberof base.object
         * @instance
         * @param {string} name Name of member function or injectable function
         * @returns {(base.object|base.module|base.module.withObject)}
         * @see Action
         */
        withFunc = function withFunc(name) {
          // todo: add warnings here
          var args = Array.prototype.slice.call(arguments, 1);
          if (angular.isObject(this.stub)) {
            this.func = sinon && sinon.stub ? sinon.stub.apply(sinon, args) :
              function debaserStub() {
              };
            this.stub[name] = this.func;
          } else {
            this.name = name;
            this.chain(bind(this, debaserConstantCallback));
            func.apply(this, arguments);
          }
        };
        withFunc.$aspect = ['module', 'object', 'withObject'];

        /**
         * @description Provides a *constant* injectable object on the module.
         * @param {string} name Name of injectable object
         * @see Action
         */
        withObject = function withObject(name) {
          this.name = name;
          this.chain(bind(this, debaserConstantCallback));
          object.apply(this, arguments);
        };
        withObject.$aspect = ['module'];

        var superpowers = {
          func: func,
          module: module,
          object: object,
          withDep: withDep,
          withDeps: withDeps,
          withFunc: withFunc,
          withObject: withObject,

          // exposed for testing
          $SINON_EXCLUDE: SINON_EXCLUDE
        };

        angular.forEach(superpowers, function (fn, name) {
          if (!fn.$name) {
            fn.$name = name;
          }
        });

        if (sinon) {
          angular.forEach(sinon.stub, function (fn, name) {
            if (angular.isFunction(fn) && SINON_EXCLUDE.indexOf(name) === -1) {
              var sinonProxy = function sinonProxy() {
                var retval = fn.apply(this.func, arguments);
                if (retval && retval.stub && retval.stub.func) {
                  /**
                   * @description Gives you a {@link Debaser} instance back if you have been setting things up via `*onCall*` methods.
                   * @function sinon.Stub#end
                   * @returns {(base.func|base.module.withFunc)}
                   */
                  retval.end = bind(this, function debaserEnd() {
                    return this;
                  });
                  return retval;
                }
              };
              sinonProxy.$aspect = ['func', 'withFunc'];
              superpowers[name] = sinonProxy;
            }
          });
        }

        return superpowers;
      }]);
})(window, window.angular);