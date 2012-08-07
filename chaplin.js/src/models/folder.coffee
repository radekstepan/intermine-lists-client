define [
    'chaplin'
    'models/lists'
], (Chaplin, Lists) ->

    class Folder extends Chaplin.Model

        defaults:
            'name':     ''    # name of a folder (last part of the path)
            'path':     '/'   # path coming from the list
            'expanded': false # is this folder expanded in the view?