module Example1 exposing (main)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation as Navigation exposing (Key)
import Html exposing (Html, div, section, text)
import Html.Attributes exposing (class)
import Component.NavBar as NavBar
import Component.NavLink exposing (NavLink(..))
import Url exposing (Url)
import Routes exposing (Route(..), parseUrl)


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none

        -- When someone clicks a link, it always goes through onUrlRequest
        , onUrlRequest = OnUrlRequest

        -- When the url changes, it's handled through onUrlChange
        , onUrlChange = OnUrlChange
        }


type Msg
    = OnUrlRequest UrlRequest
    | OnUrlChange Url


type alias Model =
    { route : Route
    , navigationKey : Key
    }


init : flags -> Url -> Key -> ( Model, Cmd Msg )
init _ initialUrl navigationKey =
    ( { route = parseUrl initialUrl
      , navigationKey = navigationKey
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -- How do we handle on url change?
        OnUrlChange newUrl ->
            ( { model | route = parseUrl newUrl }
            , Cmd.none
            )

        -- How do we handle what happens when the user click a link?
        OnUrlRequest urlRequest ->
            case urlRequest of
                Internal internUrl ->
                    ( model
                    , internUrl
                        |> Url.toString
                        |> Navigation.pushUrl model.navigationKey
                    )

                External extUrl ->
                    -- User clicked on a link that will take him to an external
                    -- site, we can do some
                    ( model, Navigation.load extUrl )


view : Model -> Document Msg
view model =
    { title = "Example 1 | Elm SPA"
    , body =
        [ div
            [ class "app" ]
            [ NavBar.view "Example one" model.route
            , content model
            ]
        ]
    }

content : Model -> Html Msg
content model =
    section
        [ class "page" ]
        [ case model.route of
            Home ->
                text "This is home page."

            Blog ->
                text "This is blog page."

            About ->
                text "This is about page."

            Contact ->
                text "This is contact page."

            NotFound ->
                text "I'm a bit lost :("
        ]
