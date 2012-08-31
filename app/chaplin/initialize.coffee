Töskur = require 'chaplin/core/Application'
Store = require 'chaplin/models/Store'

$ ->
    # Initialize the Store.
    window.Store = new Store()

    # Initialize the Application.
    window.App = new Töskur()
    window.App.initialize()