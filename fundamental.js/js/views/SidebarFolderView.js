(function() {
  var View;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  App.Views.SidebarFolderView = View = (function() {

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
        url: "js/templates/_sidebar_folder.html",
        success: function(data) {
          return result = data;
        }
      });
      return result;
    })());

    View.prototype.events = {
      "click a.toggle": "toggleFolder"
    };

    View.prototype.toggleFolder = function() {
      return $(this.el).toggleClass("active").find("ul").toggleClass("active");
    };

    View.prototype.initialize = function() {
      _.bindAll(this, "addOneList");
      _.bindAll(this, "filterLists");
      this.model.bind("change", this.render, this);
      this.model.bind("destroy", this.remove, this);
      return App.Mediator.bind("filterLists", this.filterLists);
    };

    View.prototype.addOneList = function(listName) {
      var list;
      list = App.Models.Lists.find(function(list) {
        return list.get("name") === listName;
      });
      return $(this.el).find("ul.lists").append(new App.Views.SidebarListView({
        model: list
      }).render().el);
    };

    View.prototype.filterLists = function(filter) {
      var re;
      $(this.el).find("ul.lists").remove();
      re = new RegExp(filter + ".*", "i");
      return _.each(this.model.get("lists"), (function(listName) {
        if (listName.match(re)) return this.addOneList(listName);
      }), this);
    };

    View.prototype.render = function() {
      var folder, name;
      folder = this.model;
      if (folder.get("topLevel")) {
        folder.set({
          expanded: true
        });
      }
      $(this.el).html(this.template(folder.toJSON()));
      name = folder.get("name") || "top";
      $(this.el).attr("data-list-name", name);
      _.each(folder.get("lists"), this.addOneList);
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
