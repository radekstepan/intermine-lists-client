
  App.Views.BreadcrumbView = Backbone.View.extend({
    el: "ul#breadcrumb",
    template: _.template((function() {
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
    })()),
    initialize: function(options) {
      _.bindAll(this, "render");
      _.bindAll(this, "hide");
      App.Mediator.bind("listSelected", this.render);
      return App.Mediator.bind("listDeselected", this.hide);
    },
    render: function(listName) {
      return $(this.el).html(this.template(App.Models.Lists.byName(listName).toJSON())).show();
    },
    hide: function() {
      return $(this.el).hide();
    }
  });
