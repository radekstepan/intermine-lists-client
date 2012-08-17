define [
    'chaplin'
    'core/view'
    'views/list_moving'
    'views/lists_moving'
], (Chaplin, View, ListMovingView, ListsMovingView) ->

    # A list in the main View.
    class ListView extends View

        container:       '#main table tbody'
        containerMethod: 'append'
        autoRender:      true
        tagName:         'tr'

        # Get the template from here.
        getTemplateFunction: -> JST['list']

        initialize: ->
            super

            # Select this list.
            @delegate 'click', 'input.check', @checkList

            # Create a clone of yourself while being dragged.
            $(@el).draggable
                'helper': @draggable

        afterRender: ->
            super

            $(@el).addClass('list')

        # A UI draggable helper, decides whether we move one or many items.
        draggable: =>
            # Clear any previous clone.
            @clone?.dispose()

            # How many lists are checked?
            checked = new Chaplin.Collection @model.collection.where('checked': true)

            # Are we moving just us, or many lists?
            if checked.length > 1
                # Make a reference to the collection through `data`.
                $(@el).data 'collection': checked

                # Create a View for the Collection.
                (@clone = new ListsMovingView('collection': checked)).el
            else
                # Make a reference to the collection through `data`.
                $(@el).data 'collection': new Chaplin.Collection [ @model ]

                # We ignore 1 checked list if it isn't this one.
                # One is the loneliest number there could ever be.
                (@clone = new ListMovingView('model': @model)).el

        # Check (or uncheck) this list.
        checkList: ->
            # We are OK not re-rendering the View as we need to send a message about the Model Collection.
            @model.set 'checked': !@model.get 'checked', { 'silent': true }

            # Say to others how many lists are checked.
            Chaplin.mediator.publish 'checkedLists', @model.collection.where('checked': true).length