define [
    'chaplin'
    'views/crumb_view'
], (Chaplin, CrumbView) ->

    class BreadcrumbView extends Chaplin.CollectionView

        tagName:    'li'
        container:  'ul#breadcrumb' # in the top level list
        autoRender: true            # as soon as we create us

        ###
        Instantiate an individual crumb item View.
        @param {Object} item A model
        ###
        getView: (item) -> new CrumbView 'model': item

        afterRender: ->
            super
            $(@container).show()