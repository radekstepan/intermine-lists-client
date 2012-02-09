
  window.App = {
    Mediator: {},
    Models: {},
    Views: {},
    Routers: {},
    initialize: function() {
      var lists;
      _.extend(App.Mediator, Backbone.Events);
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
      new App.Views.BreadcrumbView;
      new App.Routers.Main;
      return Backbone.history.start();
    }
  };

  $(function() {
    return App.initialize();
  });
