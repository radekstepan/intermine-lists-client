Töskur = require 'core/Application'
Store = require 'models/Store'

$ ->
    # Initialize the Store.
    window.Store = new Store()

    # Initialize the Application.
    window.App = new Töskur()
    window.App.initialize()