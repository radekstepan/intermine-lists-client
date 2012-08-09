(function() {

  define(['chaplin'], function(Chaplin) {
    var Garbage;
    return Garbage = (function() {

      Garbage.prototype.objects = null;

      function Garbage() {
        this.objects = [];
      }

      Garbage.prototype.push = function(object) {
        return this.objects.push(object);
      };

      Garbage.prototype.dispose = function() {
        var obj, _i, _len, _ref;
        _ref = this.objects;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          obj = _ref[_i];
          if (obj && typeof obj.dispose === 'function') {
            obj.dispose();
          }
        }
        delete this['objects'];
        return typeof Object.freeze === "function" ? Object.freeze(this) : void 0;
      };

      return Garbage;

    })();
  });

}).call(this);
