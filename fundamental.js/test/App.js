// InterMine MyMine App
// ----------

var App = {

	Mediator: {},

    Models: {},
    Views: {},
    Routers: {},

    init: function() {
    	// Used to pass notifications round.
    	_.extend(App.Mediator, Backbone.Events);
    	// Call the main application router.
        new App.Routers.Main;
    }

};

// Initialize the app when DOM is ready.
$(function() {
	App.init();
});