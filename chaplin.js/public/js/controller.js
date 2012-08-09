(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['chaplin'], function(Chaplin) {
    var Controller;
    return Controller = (function(_super) {

      __extends(Controller, _super);

      function Controller() {
        return Controller.__super__.constructor.apply(this, arguments);
      }

      Controller.prototype.views = {
        dispose: function() {
          return console.log('dispose called');
        }
      };

      Controller.prototype.dispose = function() {
        var obj, prop, properties, _i, _len;
        console.log('starting to dispose');
        if (this.disposed) {
          return;
        }
        for (prop in this) {
          if (!__hasProp.call(this, prop)) continue;
          obj = this[prop];
          console.log(obj);
          if (obj && typeof obj.dispose === 'function') {
            obj.dispose();
            delete this[prop];
          }
        }
        this['views'].dispose();
        this.unsubscribeAllEvents();
        properties = ['currentId', 'redirected'];
        for (_i = 0, _len = properties.length; _i < _len; _i++) {
          prop = properties[_i];
          delete this[prop];
        }
        this.disposed = true;
        return typeof Object.freeze === "function" ? Object.freeze(this) : void 0;
      };

      return Controller;

    })(Chaplin.Controller);
  });

}).call(this);
