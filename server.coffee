#!/usr/bin/env coffee

flatiron = require 'flatiron'
union    = require 'union'
connect  = require 'connect'

app = flatiron.app
app.use flatiron.plugins.http,
    'before': [
        # Have a nice favicon.
        connect.favicon()
        # Static file serving.
        connect.static './public'
    ]
    'onError': (err, req, res) ->
        if err.status is 404
            res.redirect '/', 301
        else
            # Go Union!
            union.errorHandler err, req, res

app.start 1111, (err) ->
    throw err if err
    app.log.info "Listening on port #{app.server.address().port}".green