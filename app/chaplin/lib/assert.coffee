# Simple assertion class.
class AssertException

    constructor: (@message) ->

    toString: -> "AssertException: #{@message}"

# Set the assertion on the window object.
@.assert = (exp, message) -> throw new AssertException(message) unless exp