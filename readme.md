# Routing in Elm SPA's

**Elm London Meetup 26/02/2020**

This project contains a few examples on how **single page application** routing
could be implemented in an `Elm` application.

The examples presented in this repository are to be considered as guidelines,
and not complete solutions. I would absolutely encourage you to expand upon them,
try to implement some of the other functionality, eg. how to distinguish between
public and login protected pages.

Although the examples are not intended to be applied to every specific *Elm SPA*
scenario, they should provide a good starting point for your next awesome `elm`
project.

## Getting started

To clone this repo localy
```bash
git clone git@github.com:ivan-jukic/elm-spa-examples.git
```

Install dependencies
```bash
yarn install
```

All examples are using `parceljs` for running and serving the web content.

## Example 1

This is the simplest `elm` app routing example presented here. It is based on
simple URL parsing, with no additional URL parameters. Each route is represented
with a type constructor, saved in the model, and then used to determine which
content should be displayed on the page.

To run the first example
```bash
yarn example1
```

Available at [http://localhost:3001](http://localhost:3001)

## Example 2

Second example adds on top of the first one, by separating the page content into
diffrent modules, all included in the `Main` module model. Each page has its own
`model` / `update` / `view`, and it needs to be initialised first.

This enables us to separate page specific functionality into modules, but
referencing all those page modules in the `main` model may introduce some other
problems, so generally I would **not recommend** this approach to be used for
any app with a large scope, although it may be useful for relatively simple and
straightforward apps.

Some of the problems that you may face are:
- difficult to debug issues due to multiple active pages being updated
- unable to initialise a page because of data not being available
    - either data that needs to be loaded first
    - or some data that will be available as route parameters
- performance issues

If you're sure none of these will be an issue for you, knock yourself out.

To run the second example
```bash
yarn example2
```

Available at [http://localhost:3002](http://localhost:3002)

## Example 3

Third example introduces the `content` manager component, which handles different
content intialisation, page management and updating, and removes that code from
the `main` module. The `main` module is only responsible for handling the url
changes, and making sure that the relevant content is initialised.

The `content` manager also makes sure that only one page model is initialised
at a time, therefore avoiding some of the pitfals that could be present if you
structure your app like in the second example.

To run the third example
```bash
yarn example3
```

Available at [http://localhost:3003](http://localhost:3003)

## CSS in the examples

If you've looked into the CSS code, you might have wondered why it's structured
like that. Take a look at [rscss.io](https://rscss.io/index.html),
and it might clear up a few things.

## Contributions

**PR's welcomed!**
