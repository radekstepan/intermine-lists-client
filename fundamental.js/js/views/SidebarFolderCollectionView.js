(function() {
  var View;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  App.Views.SidebarFolderCollectionView = View = (function() {

    __extends(View, Backbone.View);

    function View() {
      View.__super__.constructor.apply(this, arguments);
    }

    View.prototype.el = "ul#folders";

    View.prototype.initialize = function(options) {
      _.bindAll(this, "addOneFolder");
      App.Mediator.bind("listSelected", this.deselectOtherLists);
      return this.addAllFolders();
    };

    View.prototype.deselectOtherLists = function(folderName) {
      return _.each(App.Models.Lists.selected(), (function(list) {
        return list.set({
          selected: list.get("name") !== this ? false : void 0
        });
      }), folderName);
    };

    View.prototype.addOneFolder = function(folder) {
      return $(this.el).append(new App.Views.SidebarFolderView({
        model: folder
      }).render().el).attr("data-view", "SidebarFolderCollectionView");
    };

    View.prototype.addAllFolders = function() {
      return App.Models.Folders.each(this.addOneFolder);
    };

    return View;

  })();

}).call(this);
