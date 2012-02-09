
  window.App = {
    Mediator: {},
    Models: {},
    Views: {},
    Routers: {},
    init: function() {
      _.extend(App.Mediator, Backbone.Events);
      return new App.Routers.Main;
    }
  };

  $(function() {
    return App.init();
  });
