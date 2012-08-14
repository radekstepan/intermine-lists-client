#!/usr/bin/env coffee

flatiron = require 'flatiron'
union    = require 'union'
connect  = require 'connect'
fs       = require 'fs'

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

app.router.path '/api/lists', ->
    @get ->
        fs.readFile './data/lists.json', 'utf8', (err, data) =>
            throw err if err
            @res.writeHead 200, "content-type": "application/json;charset=utf-8"
            @res.write data
            @res.end()

app.router.path '/api/list', ->
    @get ->
        fs.readFile './data/list.json', 'utf8', (err, data) =>
            throw err if err
            @res.writeHead 200, "content-type": "application/json;charset=utf-8"
            @res.write data
            @res.end()