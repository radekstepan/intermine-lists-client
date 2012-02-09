(function() {
  var Router;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  App.Routers.Main = Router = (function() {

    __extends(Router, Backbone.Router);

    function Router() {
      Router.__super__.constructor.apply(this, arguments);
    }

    Router.prototype.initialize = function(options) {
      var lists;
      App.Models.Folders = new Folders();
      lists = [
        {
          name: "UK Cities",
          type: "Settlements",
          created: "6 Aug",
          tags: ["folder/United Kingdom", "public"]
        }, {
          name: "UK Towns",
          type: "Settlements",
          created: "5 Nov",
          tags: ["folder/United Kingdom"]
        }, {
          name: "UK Lakes",
          type: "Water",
          created: "13:45",
          tags: ["admin", "folder/United Kingdom"]
        }, {
          name: "Czech Ponds",
          type: "Water",
          created: "15 Jan 2011",
          tags: ["public", "folder/Czech Republic"]
        }, {
          name: "World Seas",
          type: "Water",
          created: "1 Feb"
        }
      ];
      App.Models.Lists = new Lists(lists);
      new App.Views.SidebarFolderCollectionView;
      return new App.Views.BreadcrumbView;
    };

    return Router;

  })();

}).call(this);
