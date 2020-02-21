module NavLink exposing (NavLink(..), view)

import Html exposing (Html, a, text)
import Html.Attributes exposing (class, classList, href)



-- Just a few convenience types for additional context


type alias Label =
    String


type alias Href =
    String


type alias IsActive =
    Bool


{-| We can distinguish two types of links, that have slight differences.
-}
type NavLink
    = NavLink Label Href IsActive
    | ExternalLink Label Href


{-| Render nav link view!
-}
view : NavLink -> Html msg
view navLink =
    case navLink of
        NavLink linkLabel linkHref isActive ->
            a
                [ class "link -nav"
                , classList [ ( "-active", isActive ) ]
                , href linkHref
                ]
                [ text linkLabel ]

        ExternalLink linkLabel linkHref ->
            a
                [ class "link -ext"
                , href linkHref
                ]
                [ text linkLabel ]
