// Import and initialise Elm app, a bit inconvenient that we cant do this from
// inside of the index template w/ parcel.

// @ts-ignore
import { Elm } from `./elm/Example1.elm`;

Elm.Example1.init({
    node: document.querySelector('main')
});
