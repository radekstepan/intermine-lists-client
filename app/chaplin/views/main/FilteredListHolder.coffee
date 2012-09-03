Mediator = require 'chaplin/core/Mediator'
Garbage = require 'chaplin/core/Garbage'
View = require 'chaplin/core/View'

FilteredListView = require 'chaplin/views/main/FilteredList'

# The filtered collection of lists.
module.exports = class FilteredListHolderView extends View

    container:       '#main'
    autoRender:      true
    containerMethod: 'html'

    initialize: ->
        super

        # The garbage truck... wroom!
        @views = new Garbage()

        # Re-render itself when others tell us to.
        Mediator.subscribe 'renderMain', @render, @

        # Listen to the inner lists being checked.
        Mediator.subscribe 'checkedLists', @updateCheckbox, @

    # Get the template from here.
    getTemplateFunction: -> require 'chaplin/templates/filtered_lists'

    # Peek into the data to show msg according to the results.
    getTemplateData: -> 'length': @collection.models.length

    afterRender: ->
        super

        # Thrash the garbage.
        @undelegate()
        @views.dump()

        # Bind to the main checkbox.
        @delegate 'click', 'input.check-all', @checkAllLists

        # Update main checkbox according to whether all is checked or not.
        @updateCheckbox()

        # Render the lists inside.
        for model in @collection.models
            @views.push view = new FilteredListView 'model': model

    # Update main checkbox according to whether all is checked or not.
    updateCheckbox: ->
        [ nay, yay ] = @checked()

        $(@el).find('input.check-all').prop 'checked', nay is 0 and yay isnt 0

    # Count the number of un-/checked lists on us.
    checked: ->
        r = [ 0, 0 ]
        for list in @collection.models
            r[0 + list.get('checked')] += 1
        r

    # Un-/check all lists in this table.
    checkAllLists: ->
        [ nay, yay ] = @checked()

        # Which action are we going to do?
        which = true
        if nay is 0 then which = false

        # Quietly execute.
        for list in @collection.models
            list.set 'checked': which, { 'silent': true }

        # Say to others how many lists are checked.
        Mediator.publish 'checkedLists', if which is true then yay + nay else 0

        # One re-render after all is done.
        @render()