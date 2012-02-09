(function() {
  var View;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  App.Views.BreadcrumbView = View = (function() {

    __extends(View, Backbone.View);

    function View() {
      View.__super__.constructor.apply(this, arguments);
    }

    View.prototype.el = "ul#breadcrumb";

    View.prototype.template = _.template((function() {
      var result;
      result = "";
      $.ajax({
        async: false,
        url: "js/templates/_breadcrumb.html",
        success: function(data) {
          return result = data;
        }
      });
      return result;
    })());

    View.prototype.initialize = function(options) {
      _.bindAll(this, "render");
      _.bindAll(this, "hide");
      App.Mediator.bind("listSelected", this.render);
      return App.Mediator.bind("listDeselected", this.hide);
    };

    View.prototype.render = function(listName) {
      return $(this.el).html(this.template(App.Models.Lists.byName(listName).toJSON())).show().attr("data-view", "BreadcrumbView");
    };

    View.prototype.hide = function() {
      return $(this.el).hide();
    };

    return View;

  })();

}).call(this);
