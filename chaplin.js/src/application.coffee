define [
    'chaplin'
    'views/layout'
    'routes'
], (Chaplin, Layout, routes) ->

    # The application object
    # Choose a meaningful name for your application
    class Töskur extends Chaplin.Application

        # Set your application name here so the document title is set to
        # “Controller title – Site title” (see Layout#adjustTitle)
        title: 'InterMine Lists Client'

        initialize: ->
            super
            #console.debug 'HelloWorldApplication#initialize'

            # Initialize core components
            @initDispatcher()
            @initLayout()
            @initTemplates()
            @initMediator()

        # Override standard layout initializer
        # ------------------------------------
        initLayout: ->
            # Use an application-specific Layout class. Currently this adds
            # no features to the standard Chaplin Layout, it’s an empty placeholder.
            @layout = new Layout {@title}

        # Create a namespace for templates.
        # ---------------------------------            
        initTemplates: -> window.JST = {}

        # Create additional mediator properties
        # -------------------------------------
        initMediator: ->
            # Create a user property
            Chaplin.mediator.user = null
            # Add additional application-specific properties and methods
            # Seal the mediator
            Chaplin.mediator.seal()