module Component.NavBar exposing (view)

import Component.NavLink as NavLink exposing (NavLink(..))
import Html exposing (Html, nav, div, text)
import Html.Attributes exposing (class)
import Routes exposing (Route(..))


view : String -> Route -> Html msg
view navTitle activeRoute =
    let
        isActive : Route -> Bool
        isActive r =
            r == activeRoute
    in
    nav [ class "nav-bar" ]
        [ div [ class "title" ]
            [ text navTitle
            ]
        , div [ class "links" ] <|
            List.map NavLink.view
                [ NavLink "Home" "/" (isActive Home)
                , NavLink "Blog" "/blog" (isActive Blog)
                , NavLink "About" "/about" (isActive About)
                , NavLink "Contact" "/contact" (isActive Contact)
                , ExternalLink "Google" "//google.co.uk"
                ]
        ]
