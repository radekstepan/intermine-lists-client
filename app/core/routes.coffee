###
The routes for the application. This module returns a function.
@param {function} match Method of the Router.
###
module.exports = (match) ->
    match '',             'toskur#index'
    match 'list/:slug',   'toskur#list'
    # Generate a 20 level deep 'nice' route for folders.
    old = 'folder'
    for i in [0...20]
        match old = "#{old}/:s#{i}", 'toskur#folder'