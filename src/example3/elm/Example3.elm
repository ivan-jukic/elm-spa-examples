module Example3 exposing (main)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation as Navigation exposing (Key)
import Html exposing (div, section)
import Html.Attributes exposing (class)
import Component.NavBar as NavBar
import Component.NavLink exposing (NavLink(..))
import Routes exposing (Route(..), parseUrl)
import Url exposing (Url)
import Content


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        , onUrlRequest = OnUrlRequest
        , onUrlChange = OnUrlChange
        }


type Msg
    = OnUrlRequest UrlRequest
    | OnUrlChange Url
    | ContentMsg Content.Msg


type alias Model =
    { route : Route
    , navigationKey : Key
    , content : Content.Model
    }


init : flags -> Url -> Key -> ( Model, Cmd Msg )
init _ initialUrl navigationKey =
    ( { route = parseUrl initialUrl
      , navigationKey = navigationKey
      , content = Content.init
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -- How do we handle on url change?
        OnUrlChange newUrl ->
            let
                newRoute =
                    parseUrl newUrl
            in
            ( { model
                | route = newRoute
                , content = setContent newRoute model.content
                }
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
        
        ContentMsg subMsg ->
            let
                (updated, subCmd) =
                    Content.update subMsg model.content
            in
            ( { model | content = updated }
            , Cmd.map ContentMsg subCmd
            )


setContent : Route -> Content.Model -> Content.Model
setContent route =
    case route of
        Home ->
            Content.initHomePage

        Blog ->
            Content.initBlogPage

        About ->
            Content.initAboutPage

        Contact ->
            Content.initContactPage

        NotFound ->
            Content.initNotFoundPage 


view : Model -> Document Msg
view model =
    { title = "Example 3 | Elm SPA"
    , body =
        [ div
            [ class "app" ]
            [ NavBar.view "Example three" model.route
            , section
                [ class "page" ]
                [ Html.map ContentMsg <|
                    Content.view model.content
                ]
            ]
        ]
    }    
