(function() {
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  App.Views.SidebarListView = (function() {

    __extends(SidebarListView, Backbone.View);

    function SidebarListView() {
      SidebarListView.__super__.constructor.apply(this, arguments);
    }

    SidebarListView.prototype.tagName = "li";

    SidebarListView.prototype.template = _.template((function() {
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

    SidebarListView.prototype.events = {
      "click a": "toggleList"
    };

    SidebarListView.prototype.toggleList = function() {
      this.model.toggleSelected();
      return App.Mediator.trigger((this.model.get("selected") ? "listSelected" : "listDeselected"), this.model.get("name"));
    };

    SidebarListView.prototype.initialize = function() {
      this.model.bind("change", this.render, this);
      return this.model.bind("destroy", this.remove, this);
    };

    SidebarListView.prototype.render = function() {
      $(this.el).html(this.template(this.model.toJSON())).attr("data-view", "SidebarListView");
      if (this.model.get("selected")) {
        $(this.el).addClass("active");
      } else {
        $(this.el).removeClass("active");
      }
      return this;
    };

    SidebarListView.prototype.remove = function() {
      return $(this.el).remove();
    };

    SidebarListView.prototype.clear = function() {
      return this.model.destroy();
    };

    return SidebarListView;

  })();

}).call(this);
