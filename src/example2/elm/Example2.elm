module Example2 exposing (main)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation as Navigation exposing (Key)
import Html exposing (Html, div, section)
import Html.Attributes exposing (class)
import Component.NavBar as NavBar
import Component.NavLink exposing (NavLink(..))
import Routes exposing (Route(..), parseUrl)
import Url exposing (Url)
import Page.Home as HomePage
import Page.Blog as BlogPage
import Page.About as AboutPage
import Page.Contact as ContactPage
import Page.NotFound as NotFoundPage


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
    | HomePageMsg HomePage.Msg
    | BlogPageMsg BlogPage.Msg
    | AboutPageMsg AboutPage.Msg
    | ContactPageMsg ContactPage.Msg


type alias Model =
    { route : Route
    , navigationKey : Key
    , homePage : HomePage.Model
    , blogPage : BlogPage.Model
    , aboutPage : AboutPage.Model
    , contactPage : ContactPage.Model
    }


init : flags -> Url -> Key -> ( Model, Cmd Msg )
init _ initialUrl navigationKey =
    ( { route = parseUrl initialUrl
      , navigationKey = navigationKey
      , homePage = HomePage.init
      , blogPage = BlogPage.init
      , aboutPage = AboutPage.init
      , contactPage = ContactPage.init
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnUrlChange newUrl ->
            ( { model | route = parseUrl newUrl }
            , Cmd.none
            )

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
        
        HomePageMsg subMsg ->
            let
                (updated, subCmd) =
                    HomePage.update subMsg model.homePage
            in
            ( { model | homePage = updated }
            , Cmd.map HomePageMsg subCmd
            )

        BlogPageMsg subMsg ->
            let
                (updated, subCmd) =
                    BlogPage.update subMsg model.blogPage
            in
            ( { model | blogPage = updated }
            , Cmd.map BlogPageMsg subCmd
            )

        AboutPageMsg subMsg ->
            let
                (updated, subCmd) =
                    AboutPage.update subMsg model.aboutPage
            in
            ( { model | aboutPage = updated }
            , Cmd.map AboutPageMsg subCmd
            )

        ContactPageMsg subMsg ->
            let
                (updated, subCmd) =
                    ContactPage.update subMsg model.contactPage
            in
            ( { model | contactPage = updated }
            , Cmd.map ContactPageMsg subCmd
            )


view : Model -> Document Msg
view model =
    { title = "Example 2 | Elm SPA"
    , body =
        [ div
            [ class "app" ]
            [ NavBar.view "Example two" model.route
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
                Html.map HomePageMsg <|
                    HomePage.view model.homePage

            Blog ->
                Html.map BlogPageMsg <|
                    BlogPage.view model.blogPage

            About ->
                Html.map AboutPageMsg <|
                    AboutPage.view model.aboutPage

            Contact ->
                Html.map ContactPageMsg <|
                    ContactPage.view model.contactPage

            NotFound ->
                NotFoundPage.view
        ]
