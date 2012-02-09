# InterMine MyMine App
# ----------
window.App =
    Mediator: {}
    
    Models: {}
    Views: {}
    Routers: {}
    
    init: ->
        # Used to pass notifications round.
        _.extend(App.Mediator, Backbone.Events)
        # Call the main application router.
        new App.Routers.Main

# Initialize the app when DOM is ready.
$ ->
    App.init()