Backbone = require 'backbone'

module.exports = mediator = {}

mediator.publish = (opts...) ->
    Backbone.Events.trigger opts...

mediator.subscribe = (opts...) ->
    Backbone.Events.on opts...

# Assert the existence of the channel (to avoid typos).
mediator.unsubscribe = (opts...) ->
    # We need to have SOME channels...
    assert Backbone.Events._callbacks?, 'No channels exist'
    # If we have defined channel, check if it exists in callbacks.
    if (channel = opts[0])? then assert Backbone.Events._callbacks[channel]?, "Unknown channel `#{channel}`"
    # Pass on to Backbone.
    Backbone.Events.off opts...

# List all existing channels.
mediator.channels = -> Object.keys Backbone.Events._callbacks

# Reset all channels.
mediator.reset = -> Backbone.Events._callbacks = null