define [
    'chaplin'
    'views/crumb_view'
], (Chaplin, CrumbView) ->

    class BreadcrumbView extends Chaplin.CollectionView

        container:  'ul#breadcrumb' # in the top level list
        className:  'breadcrumb'
        autoRender: true            # as soon as we create us

        getView: (item) ->
            # Instantiate an individual crumb item View.
            new CrumbView 'model': item