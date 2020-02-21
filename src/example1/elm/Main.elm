module Main exposing (main)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation as Navigation exposing (Key)
import Html exposing (Html, div, nav, section, text)
import Html.Attributes exposing (class)
import NavLink exposing (NavLink(..))
import Url exposing (Url)
import Url.Parser as Url


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
    = OnUrlRequest UrlRequest
    | OnUrlChange Url


type alias Model =
    { route : Route
    , navigationKey : Key
    }


type Route
    = Homepage
    | Blog
    | About
    | Contact
    | NotFound


parseUrl : Url -> Route
parseUrl url =
    Maybe.withDefault NotFound <|
        Url.parse
            (Url.oneOf
                [ Url.map Homepage Url.top
                , Url.map Blog (Url.s "blog")
                , Url.map About (Url.s "about")
                , Url.map Contact (Url.s "contact")
                ]
            )
            url


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
                    ( model, Navigation.load extUrl )


view : Model -> Document Msg
view model =
    { title = "Example 1 | Elm SPA"
    , body =
        [ div
            [ class "app" ]
            [ navBar model
            , content model
            ]
        ]
    }


navBar : Model -> Html Msg
navBar model =
    let
        isActive : Route -> Bool
        isActive r =
            r == model.route

        navLinks : List (Html Msg)
        navLinks =
            List.map NavLink.view
                [ NavLink "Homepage" "/" (isActive Homepage)
                , NavLink "Blog" "/blog" (isActive Blog)
                , NavLink "About" "/about" (isActive About)
                , NavLink "Contact" "/contact" (isActive Contact)
                , ExternalLink "Google" "//google.co.uk"
                ]
    in
    nav [ class "nav-bar" ]
        [ div [ class "title" ] [ text "Example One" ]
        , div [ class "links" ] navLinks
        ]


content : Model -> Html Msg
content model =
    section
        [ class "page" ]
        [ case model.route of
            Homepage ->
                text "This is homepage."

            Blog ->
                text "This is blog page."

            About ->
                text "This is about page."

            Contact ->
                text "This is contact page."

            NotFound ->
                text "I'm a bit lost :("
        ]
