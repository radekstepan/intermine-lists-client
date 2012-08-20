# InterMine Lists Client

A client side app maintaining InterMine Lists offering folder/tag organization and live searches.

The app is powered by [chaplin](https://github.com/chaplinjs/chaplin) that itself wraps [Backbone.js](http://documentcloud.github.com/backbone/).

![image](https://github.com/radekstepan/intermine-lists-client/raw/master/example.png)

## Stack

The whole stack is built on top of the [node.js](http://nodejs.org/) platform, make sure it is installed.

### Brunch
[Brunch](http://brunch.io/) is a html5 application builder that's agnostic to programming langs and frameworks.

`config.coffee` contains brunch configuration, `package.json` contains brunch plugins.

### Chaplin
[Chaplin](https://github.com/chaplinjs/chaplin) is a framework on top of [Backbone.js](http://backbonejs.org/) that adds some great predefined structure, like `ModelView`, `Controller`, `mediator`, `Application`.

### Eco
[Eco](https://github.com/sstephenson/eco/) lets you embed CoffeeScript logic in your markup. It's like EJS and ERB, but with CoffeeScript inside.

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