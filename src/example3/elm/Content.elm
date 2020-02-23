module Content exposing
    ( Content(..)
    , Msg
    , Model
    , init
    , initHomePage
    , initBlogPage
    , initAboutPage
    , initContactPage
    , initNotFoundPage
    , update
    , view
    )

import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Page.Home as HomePage
import Page.Blog as BlogPage
import Page.About as AboutPage
import Page.Contact as ContactPage
import Page.NotFound as NotFoundPage


type Content
    = ContentHome HomePage.Model
    | ContentBlog BlogPage.Model
    | ContentAbout AboutPage.Model
    | ContentContact ContactPage.Model
    | ContentNotFound


type Msg
    = HomePageMsg HomePage.Msg
    | BlogPageMsg BlogPage.Msg
    | AboutPageMsg AboutPage.Msg
    | ContactPageMsg ContactPage.Msg


type alias Model =
    { content : Content
    , anyOtherProperty : String
    }


init : Model
init =
    { content = ContentHome HomePage.init
    , anyOtherProperty = "add here"
    }


initHomePage : Model -> Model
initHomePage model =
    { model | content = ContentHome HomePage.init }


initBlogPage : Model -> Model
initBlogPage model =
    { model | content = ContentBlog BlogPage.init }


initAboutPage : Model -> Model
initAboutPage model =
    { model | content = ContentAbout AboutPage.init }


initContactPage : Model -> Model
initContactPage model =
    { model | content = ContentContact ContactPage.init }


initNotFoundPage : Model -> Model
initNotFoundPage model =
    { model |  content = ContentNotFound }


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        HomePageMsg subMsg ->
            case model.content of
                ContentHome m ->
                    let
                        (updated, subCmd) =
                            HomePage.update subMsg m
                    in
                    ( { model | content = ContentHome updated }
                    , Cmd.map HomePageMsg subCmd
                    )

                _ ->
                    (model, Cmd.none)

        BlogPageMsg subMsg ->
            case model.content of
                ContentBlog m ->
                    let
                        (updated, subCmd) =
                            BlogPage.update subMsg m
                    in
                    ( { model | content = ContentBlog updated }
                    , Cmd.map BlogPageMsg subCmd
                    )

                _ ->
                    (model, Cmd.none)

        AboutPageMsg subMsg ->
            case model.content of
                ContentAbout m ->
                    let
                        (updated, subCmd) =
                            AboutPage.update subMsg m
                    in
                    ( { model | content = ContentAbout updated }
                    , Cmd.map AboutPageMsg subCmd
                    )

                _ ->
                    (model, Cmd.none)

        ContactPageMsg subMsg ->
            case model.content of
                ContentContact m ->
                    let
                        (updated, subCmd) =
                            ContactPage.update subMsg m
                    in
                    ( { model | content = ContentContact updated }
                    , Cmd.map ContactPageMsg subCmd
                    )

                _ ->
                    (model, Cmd.none)


view : Model -> Html Msg
view model =
    div [ class "content" ]
        [ case model.content of
            ContentHome m ->
                Html.map HomePageMsg <|
                    HomePage.view m

            ContentBlog m ->
                Html.map BlogPageMsg <|
                    BlogPage.view m

            ContentAbout m ->
                Html.map AboutPageMsg <|
                    AboutPage.view m

            ContentContact m ->
                Html.map ContactPageMsg <|
                    ContactPage.view m

            ContentNotFound ->
                NotFoundPage.view
        ]
