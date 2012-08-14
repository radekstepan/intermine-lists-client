define ->
    
    ###
    The routes for the application. This module returns a function.
    @param {function} match Method of the Router.
    ###
    (match) ->
        match '',             'toskur#index'
        match 'list/:slug',   'toskur#list'
        match 'folder/:slug', 'toskur#folder'