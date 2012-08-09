define ->
    
    # The routes for the application. This module returns a function.
    # `match` is match method of the Router
    (match) ->
        match '', 			'toskur#index'
        match 'list/:slug', 'toskur#findOne'