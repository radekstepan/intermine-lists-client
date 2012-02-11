A client side app maintaining InterMine Lists offering folder/tag organization and live searches.

## Uses:
- CoffeeScript
- Backbone.js (client side MVC)
- jQuery (DOM manipulation)
- underscore.js (functional collection works)
- Twitter Bootstrap 2.0 (*in prototyping stages*)

## Run:
1. `cd fundamental.js/`
2. `./compile.sh` compiles .coffee to .js and copies any other files to their respective folders in `js/`
3. `./webserver.sh`

## Architecture:
- Check `diagrams/` for maintained diagrams of the app.
- Models do not touch DOM.
- Views talk to other Views through a Mediator.
- Model emits messages through Mediator.
- Router does not talk to Views.

## Other:
- Libraries are not maintained in `src/`.
- Use Twitter Bootstrap for as long as possible.
- Use brackets in CoffeeScript function calls.
- Use CofeeScript > underscore.js where possible.
- Try not to be smart, code needs to be understandable...