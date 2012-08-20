exports.config =
    files:
        javascripts:
            defaultExtension: 'coffee'
            joinTo:
                'js/app.js': /^app/
                'js/vendor.js': /^vendor/
            order:
                before: [
                    'vendor/js/jquery-1.7.2.js',
                    'vendor/js/underscore-1.3.3.js',
                    'vendor/scripts/backbone-0.9.2.js'
                ]

        stylesheets:
            defaultExtension: 'css'
            joinTo:
                'css/app.css': /^assets/
                'css/vendor.css': /^vendor/
            order:
                before: [ 'vendor/css/bootstrap.css' ]

        templates:
            defaultExtension: 'eco'
            joinTo: 'js/app.js'

    server:
        path: 'server.coffee'
        port: 1111
        run: yes