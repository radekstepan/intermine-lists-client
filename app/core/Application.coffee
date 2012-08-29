Chaplin = require 'chaplin'

routes = require 'core/routes'

require 'lib/string' # latinisation, slugification for the rest of us...
require 'lib/assert' # assertions

# The application object.
module.exports = class Töskur extends Chaplin.Application

    title: 'InterMine List Client "Töskur"'

    data: {}

    initialize: ->
        super

        # Initialize core components
        @initDispatcher()
        @initMediator()

        # So that nice Controller switching works...
        @layout = new Chaplin.Layout {@title}

        # Register all routes and start routing
        @initRouter routes

        # Freeze the application instance to prevent further changes
        Object.freeze? @

    # Create additional mediator properties.
    initMediator: ->
        # Create a user property
        Chaplin.mediator.user = null
        # Add additional application-specific properties and methods
        # Seal the mediator
        Chaplin.mediator.seal()