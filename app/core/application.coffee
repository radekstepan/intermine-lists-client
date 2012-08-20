Chaplin = require 'chaplin'
Layout = require 'views/layout'
routes = require 'core/routes'
require 'lib/string' # latinisation, slugification for the rest of us...

# The application object.
module.exports = class Töskur extends Chaplin.Application

    title: 'InterMine List Client "Töskur"'

    data: {}

    initialize: ->
        super

        # Initialize core components
        @initDispatcher()
        @initLayout()
        @initMediator()

        @initData =>
            # Register all routes and start routing
            @initRouter routes

            # Freeze the application instance to prevent further changes
            Object.freeze? @

    # Get the data from the API.
    initData: (done) ->
        # Lists.
        $.getJSON '/api/lists', (data) =>
            @data.lists = data

            # Its contents.
            $.getJSON '/api/list', (data) =>
                @data.list = data
                done()

    # Override standard layout initializer.
    initLayout: ->
        # Use an application-specific Layout class. Currently this adds
        # no features to the standard Chaplin Layout, it’s an empty placeholder.
        @layout = new Layout {@title}

    # Create additional mediator properties.
    initMediator: ->
        # Create a user property
        Chaplin.mediator.user = null
        # Add additional application-specific properties and methods
        # Seal the mediator
        Chaplin.mediator.seal()