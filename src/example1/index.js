// Import and initialise Elm app, a bit inconvenient that we cant do this from
// inside of the index template w/ parcel.
import { Elm } from './elm/Main.elm'

Elm.Main.init({
    node: document.querySelector('main')
});
