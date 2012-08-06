define [
    'chaplin'
    'views/layout'
    'routes'
], (Chaplin, Layout, routes) ->

    # The application object
    # Choose a meaningful name for your application
    class Töskur extends Chaplin.Application

        initialize: ->
            super

            # Initialize core components
            @initDispatcher()
            @initLayout()
            @initMediator()

            # Register all routes and start routing
            @initRouter routes

            # Freeze the application instance to prevent further changes
            Object.freeze? @

        # Override standard layout initializer
        # ------------------------------------
        initLayout: ->
            # Use an application-specific Layout class. Currently this adds
            # no features to the standard Chaplin Layout, it’s an empty placeholder.
            @layout = new Layout()

        # Create additional mediator properties
        # -------------------------------------
        initMediator: ->
            # Create a user property
            Chaplin.mediator.user = null
            # Add additional application-specific properties and methods
            # Seal the mediator
            Chaplin.mediator.seal()