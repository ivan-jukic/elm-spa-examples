module Main exposing (..)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation exposing (Key)
import Content exposing (Content(..))
import Html exposing (div, text)
import Html.Attributes exposing (class)
import Url exposing (Url)


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none

        -- When someone clicks a link, it always goes through onUrlRequest
        , onUrlRequest = OnUrlRequest

        -- Whrn the url changes, it's handled through onUrlChange
        , onUrlChange = OnUrlChange
        }


type Msg
    = NoOp
    | OnUrlRequest UrlRequest
    | OnUrlChange Url


type alias Model =
    { content : Content
    , navigationKey : Key
    }


init : flags -> Url -> Key -> ( Model, Cmd Msg )
init _ url navigationKey =
    ( { content = Homepage
      , navigationKey = navigationKey
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        OnUrlChange newUrl ->
            -- How do we handle on url change?
            ( model, Cmd.none )

        OnUrlRequest urlRequest ->
            -- How do we handle what happens when the user click a link?
            ( model, Cmd.none )


view : Model -> Document Msg
view model =
    { title = "Example 1 | Elm SPA"
    , body =
        [ div
            [ class "app" ]
            [ text "Elm SPA example 1"
            ]
        ]
    }
