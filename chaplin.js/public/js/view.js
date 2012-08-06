(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['chaplin'], function(Chaplin) {
    var View;
    return View = (function(_super) {

      __extends(View, _super);

      function View() {
        return View.__super__.constructor.apply(this, arguments);
      }

      View.prototype.afterRender = function() {
        var name;
        View.__super__.afterRender.apply(this, arguments);
        if ((name = this.constructor.name) !== 'NotificationView') {
          return Chaplin.mediator.publish('notification', "" + name + " rendered");
        }
      };

      return View;

    })(Chaplin.View);
  });

}).call(this);
