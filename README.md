# InterMine Lists Client "Töskur"

A client side app maintaining InterMine Lists offering folder/tag organization and live searches.

The app is powered by [Chaplin](https://github.com/chaplinjs/chaplin) that itself wraps [Backbone.js](http://documentcloud.github.com/backbone/).

![image](https://github.com/radekstepan/intermine-lists-client/raw/master/example.png)

## Stack

The whole stack is built on top of the [node.js](http://nodejs.org/) platform, make sure it is installed.

### Brunch
[Brunch](http://brunch.io/) is a HTML5 application builder that's agnostic to programming langs and frameworks.

`config.coffee` contains brunch configuration, `package.json` contains brunch plugins and node config.

For the latest in Brunch documentation, head over to [Read the Docs](http://brunch.readthedocs.org/en/latest/).

### Chaplin
[Chaplin](https://github.com/chaplinjs/chaplin) is a framework on top of [Backbone.js](http://backbonejs.org/) that adds some great predefined structure, like `ModelView`, `Controller`, `mediator`, `Application`.

We further extend it by adding classes such as the `Garbage` one, that consumes objects to dispose of automatically when they are no longer needed.

All `View` objects, when instantiated, will publish a message on the `notification` channel saying that they have rendered.

### Eco
[Eco](https://github.com/sstephenson/eco/) lets you embed CoffeeScript logic in your markup. It's like EJS and ERB, but with CoffeeScript inside.

### Stylus
[Stylus](http://learnboost.github.com/stylus/) is a CSS preprocessor with flexible syntax that looks similar to CoffeeScript, mixins, variables and utility functions for color manipulations that make it easy(-ier) to develop themes.

### Flatiron
[Flatiron](http://flatironjs.org/) is used to serve files and data. Does not play a large role here.

## Getting started

Install the dependencies:

```bash
$ npm install -d
```

Run the server and compile the client watching for changes:

```bash
$ npm start
```

Visit [http://127.0.0.1:1111](http://127.0.0.1:1111).

## Production

To build the files for production, execute the process with the minify `option`:

```bash
$ node_modules/.bin/brunch build --minify
```

## [Requirements](https://github.com/radekstepan/intermine-lists-client/issues)

Following is a list of high level architectural, design and feature requirements as is/will be implemented/not. ~~Strikethrough~~ are implemented.

### Features

1. Have folders and subfolders for lists (*Boris*, *Enrico*)
    1. ~~Drag & drop lists~~. Like in Google Docs
    1. ~~Organize lists into a folder~~. Like in Google Docs
    1. ~~Create a new folder~~. Like in Google Docs
    1. Drag & drop folders.
1. Venn diagrams showing overlap between multiple lists selected (*Jie*)
1. Order lists by date, name, number of objects and have this setting stick around (*Simon*, *Enrico*)
1. Have tags that can be searched to filter lists (*Enrico*)
1. ~~Filter lists by their name~~ (*Enrico*)
1. Export lists.
1. Edit list description and date (*Hilde*)
1. When upgrading a list say how big it is and how long the upgrade process will probably take (*Sergio*)
1. Share lists with others (new functionality added by *Daniela*)

### Architecture

1. ~~Client side JavaScript architecture~~. Using Chaplin wrapped around Backbone
1. ~~Maintainable templating language~~. Eco lets us use CoffeeScript inside HTML
1. ~~CSS preprocessor for easy theming~~. Stylus as it looks closest to CoffeeScript and has coolio features like Color operations `darken()` and clear cut functions.
1. ~~Automagically package resources~~. Brunch
1. ~~Make JS files required through CommonJS/AMD~~. Brunch
1. ~~Automagically reload the client on changes~~. Brunch
1. ~~A nicer more readable language for classes~~. CoffeeScript
1. ~~CSS based off of a library~~. Twitter Bootstrap
1. ~~Manage resource usage of a client side app~~. Chaplin `dispose()` and our `class Garbage`
1. ~~Implement assertions especially on init of methods/classes to catch the unexpected~~. our `class AssertException`
1. ~~Cross-module communication using the Mediator and Publish/Subscribe patterns~~. Chaplin
1. ~~Make local links accessible from the outside~~. Lists and Folders map through routes and Flatiron always serves the `index.html` regardless of the route requested and the Chaplin instantiates the appropriate controller method.

### Design

1. classify list objects so that they can be custom styled by the different mines.