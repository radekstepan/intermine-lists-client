(function() {
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  window.Folder = (function() {

    __extends(Folder, Backbone.Model);

    function Folder() {
      Folder.__super__.constructor.apply(this, arguments);
    }

    Folder.prototype.defaults = {
      name: "#",
      lists: [],
      expanded: false,
      topLevel: false
    };

    return Folder;

  })();

  window.Folders = (function() {

    __extends(Folders, Backbone.Collection);

    function Folders() {
      Folders.__super__.constructor.apply(this, arguments);
    }

    Folders.prototype.model = Folder;

    Folders.prototype.comparator = function(folder) {
      return folder.get("name");
    };

    return Folders;

  })();

  Folders.prototype.add = function(folder) {
    var existing, lists;
    if ((existing = this.find(function(_folder) {
      return _folder.get("name") === folder.get("name");
    }))) {
      lists = existing.get("lists");
      existing.get("lists").push(folder.get("lists")[0]);
      existing.set({
        "lists": lists
      });
      return false;
    }
    return Backbone.Collection.prototype.add.call(this, folder);
  };

}).call(this);
