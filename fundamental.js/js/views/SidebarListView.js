(function() {
  var View;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  App.Views.SidebarListView = View = (function() {

    __extends(View, Backbone.View);

    function View() {
      View.__super__.constructor.apply(this, arguments);
    }

    View.prototype.tagName = "li";

    View.prototype.template = _.template((function() {
      var result;
      result = "";
      $.ajax({
        async: false,
        url: "js/templates/_sidebar_list.html",
        success: function(data) {
          return result = data;
        }
      });
      return result;
    })());

    View.prototype.events = {
      "click a": "toggleList"
    };

    View.prototype.toggleList = function() {
      this.model.toggleSelected();
      return App.Mediator.trigger((this.model.get("selected") ? "listSelected" : "listDeselected"), this.model.get("name"));
    };

    View.prototype.initialize = function() {
      this.model.bind("change", this.render, this);
      return this.model.bind("destroy", this.remove, this);
    };

    View.prototype.render = function() {
      $(this.el).html(this.template(this.model.toJSON())).attr("data-view", "SidebarListView");
      if (this.model.get("selected")) {
        $(this.el).addClass("active");
      } else {
        $(this.el).removeClass("active");
      }
      return this;
    };

    View.prototype.remove = function() {
      return $(this.el).remove();
    };

    View.prototype.clear = function() {
      return this.model.destroy();
    };

    return View;

  })();

}).call(this);
