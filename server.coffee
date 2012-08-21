#!/usr/bin/env coffee

flatiron = require 'flatiron'
union    = require 'union'
connect  = require 'connect'
send     = require 'send'
fs       = require 'fs'
require 'colors'

# Export for Brunch.
exports.startServer = (port, dir) ->
    app = flatiron.app
    app.use flatiron.plugins.http,
        'before': [
            # Have a nice favicon.
            connect.favicon()
            # Static file serving.
            connect.static "./#{dir}"
        ]
        'onError': (err, req, res) ->
            if err.status is 404
                # Are we trying to access a pushState url?
                if req.url.match(new RegExp('^/toskur', 'i'))
                    # Silently serve the root of the client app.
                    send(req, 'index.html')
                        .root('./public')
                        .on('error', union.errorHandler)
                        .pipe(res)
            else
                # Go Union!
                union.errorHandler err, req, res

    app.start port, (err) ->
        throw err if err