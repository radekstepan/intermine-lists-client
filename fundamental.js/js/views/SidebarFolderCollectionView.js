(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; }, __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  App.Views.SidebarFolderCollectionView = (function() {

    __extends(SidebarFolderCollectionView, Backbone.View);

    function SidebarFolderCollectionView() {
      this.addOneFolder = __bind(this.addOneFolder, this);
      SidebarFolderCollectionView.__super__.constructor.apply(this, arguments);
    }

    SidebarFolderCollectionView.prototype.el = "ul#folders";

    SidebarFolderCollectionView.prototype.initialize = function(options) {
      App.Mediator.bind("listSelected", this.deselectOtherLists);
      return this.addAllFolders();
    };

    SidebarFolderCollectionView.prototype.deselectOtherLists = function(folderName) {
      return _.each(App.Models.Lists.selected(), (function(list) {
        if (list.get("name") !== folderName) {
          return list.set({
            selected: false
          });
        }
      }));
    };

    SidebarFolderCollectionView.prototype.addOneFolder = function(folder) {
      return $(this.el).append(new App.Views.SidebarFolderView({
        model: folder
      }).render().el).attr("data-view", "SidebarFolderCollectionView");
    };

    SidebarFolderCollectionView.prototype.addAllFolders = function() {
      return App.Models.Folders.each(this.addOneFolder);
    };

    return SidebarFolderCollectionView;

  })();

}).call(this);
