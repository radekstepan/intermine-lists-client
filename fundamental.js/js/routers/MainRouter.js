(function() {
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  App.Routers.Main = (function() {

    __extends(Main, Backbone.Router);

    function Main() {
      Main.__super__.constructor.apply(this, arguments);
    }

    Main.prototype.routes = {
      "list/:slug": "list"
    };

    Main.prototype.list = function(slug) {
      var list;
      if (list = App.Models.Lists.bySlug(slug)) {
        return list.setSelected();
      } else {
        return _.each(App.Models.Lists.selected(), function(list) {
          return list.set({
            "selected": false
          });
        });
      }
    };

    return Main;

  })();

}).call(this);
