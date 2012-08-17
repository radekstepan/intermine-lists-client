# InterMine Lists Client

A client side app maintaining InterMine Lists offering folder/tag organization and live searches.

The app is powered by [chaplin](https://github.com/chaplinjs/chaplin) that itself wraps [Backbone.js](http://documentcloud.github.com/backbone/).

![image](https://github.com/radekstepan/intermine-lists-client/raw/master/example.png)

## Run

Make sure that [node.js](http://nodejs.org/) platform is installed.

Then install dependencies.

```bash
$ npm install -d
```

Use cake to compile the client side app.

```bash
$ ./node_modules/.bin/cake client
```

Then execute the flatiron webserver:

```bash
$ ./node_modules/.bin/coffee server.coffee
```

Visit [http://127.0.0.1:1111](http://127.0.0.1:1111).

## Cloc 1.09

```bash
$ cloc public/js/ --exclude-dir=vendor
```

```
-------------------------------------------------------------------------------
Language          files     blank   comment      code    scale   3rd gen. equiv
-------------------------------------------------------------------------------
Javascript           46       508       110      1660 x   1.48 =        2456.80
-------------------------------------------------------------------------------
SUM:                 46       508       110      1660 x   1.48 =        2456.80
-------------------------------------------------------------------------------
```