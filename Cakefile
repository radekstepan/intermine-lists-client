#!/usr/bin/env coffee

fs  = require 'fs'
cs  = require 'coffee-script'
eco = require 'eco'
require 'colors'

task "client", "compile the chaplin.js and eco client code into js", ->
    config = JSON.parse fs.readFileSync './package.json'

    console.log "#{config.name} #{config.version}".bold

    coffee = (done) ->
        walk './src', /\.coffee$/, (err, files) ->
            throw err if err

            for file in files
                console.log file.grey
                path = file.replace('/src/', '/public/js/').replace('.coffee', '.js')
                write path, cs.compile fs.readFileSync(file, "utf-8")

            done()

    templates = (done) ->
        walk './src/templates', /\.eco$/, (err, files) ->
            throw err if err
            
            js = [ 'window.JST = {};' ]
            for file in files
                console.log file.grey
                name = file.split('/').pop().split('.')[0]
                js.push uglify "window.JST['#{name}'] = " + eco.precompile fs.readFileSync file, "utf-8"

            # Write as one js file.
            write "./public/js/templates/all.js", js.join "\n"

            done()

    queue [ coffee, templates ], (out) ->
        console.log 'All is well.'.green

# -------------------------------------------------------------------


# A serial queue that waits until all resources have returned and then calls back.
queue = (calls, cb) ->
    make = (index) ->
      ->
        counter--
        all[index] = arguments
        cb(all) unless counter

    # How many do we have?
    counter = calls.length
    # Store results here.
    all = []

    i = 0
    for call in calls
        call make i++

# Traverse a directory and return a list of files (async, recursive).
walk = (path, filter, callback) ->
    results = []
    # Read directory.
    fs.readdir path, (err, list) ->
        # Problems?
        return callback err if err
        
        # Get listing length.
        pending = list.length

        return callback null, results unless pending # Done already?
        
        # Traverse.
        list.forEach (file) ->
            # Form path
            file = "#{path}/#{file}"
            fs.stat file, (err, stat) ->
                # Subdirectory.
                if stat and stat.isDirectory()
                    walk file, filter, (err, res) ->
                        # Append result from sub.
                        results = results.concat(res)
                        callback null, results unless --pending # Done yet?
                # A file.
                else
                    if filter?
                        if file.match filter then results.push file
                    else
                        results.push file
                    callback null, results unless --pending # Done yet?

# Compress using `uglify-js`.
uglify = (input) ->
    jsp = require("uglify-js").parser
    pro = require("uglify-js").uglify

    pro.gen_code pro.ast_squeeze pro.ast_mangle jsp.parse input

# Write to file.
write = (path, text, mode = "w") ->
    writeFile = (path) ->
        fs.open path, mode, 0o0666, (err, id) ->
            throw err if err
            fs.write id, text, null, "utf8"

    # Create the directory if it does not exist first.
    dir = path.split('/').reverse()[1...].reverse().join('/')
    if dir isnt '.'
        fs.mkdir dir, 0o0777, ->
            writeFile path
    else
        writeFile path