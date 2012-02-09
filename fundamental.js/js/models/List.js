(function() {
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  window.List = (function() {

    __extends(List, Backbone.Model);

    function List() {
      List.__super__.constructor.apply(this, arguments);
    }

    List.prototype.defaults = {
      name: "",
      type: "",
      created: "",
      folder: "",
      selected: false
    };

    List.prototype.initialize = function() {
      var folder;
      folder = void 0;
      _.find(this["attributes"]["tags"], (function(tag) {
        if (tag.substring(0, 7) === "folder/") return folder = tag.substring(7);
      }));
      this.set({
        folder: folder || false
      });
      return App.Models.Folders.add(new Folder({
        name: folder,
        lists: [this["attributes"]["name"]],
        topLevel: (folder ? false : true)
      }));
    };

    List.prototype.toggleSelected = function() {
      return this.set({
        selected: !this.get("selected")
      });
    };

    List.prototype.setSelected = function() {
      return this.set({
        selected: true
      });
    };

    return List;

  })();

  window.Lists = (function() {

    __extends(Lists, Backbone.Collection);

    function Lists() {
      Lists.__super__.constructor.apply(this, arguments);
    }

    Lists.prototype.model = List;

    Lists.prototype.selected = function() {
      return this.filter(function(list) {
        return list.get("selected");
      });
    };

    Lists.prototype.deselected = function() {
      return this.filter(function(list) {
        return !list.get("selected");
      });
    };

    Lists.prototype.byName = function(name) {
      return this.find(function(list) {
        return list.get("name") === name;
      });
    };

    Lists.prototype.comparator = function(list) {
      return list.get("name");
    };

    return Lists;

  })();

}).call(this);
