###
The routes for the application. This module returns a function.
@param {function} match Method of the Router.
###
module.exports = (match) ->
    match '',                  'toskur#index'
    match 'toskur/index',      'toskur#index'
    match 'toskur/list/:slug', 'toskur#list'
    # Generate a 20 level deep 'nice' route for folders.
    old = 'toskur/folder'
    for i in [0...20]
        match old = "#{old}/:s#{i}", 'toskur#folder'