# Routing in Elm SPA's

**Elm London Meetup 26/02/2020**

This project contains a few examples on how URL routing could be implemented in
an Elm SPA application. None of the examples in this project are **the solution**
to implement routing in your Elm app, but more of guidelines on how this could
be achieved.

Your app might have some specific behaviour that examples presented here might
not be able to handle, but they might provide you with an *idea* on how to
extend the functionality and achieve the desired result.

## Getting started

To clone this repo localy
```bash
git clone git@github.com:ivan-jukic/elm-spa-routing-examples.git
```

Install dependencies
```bash
yarn install
```

All examples are using `parceljs` for running and serving the web content.

## Example 1

This is the simples example of routing in an Elm app. It is based on simple URL
parsing, with no additional URL parameters. Each route is represented with a
type constructor, saved in the model, and then used to determine which content
should be displayed on the page.

To run the first example
```bash
yarn example1
```

It will be available at [http://localhost:3001](http://localhost:3001).
