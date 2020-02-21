module Content exposing (..)


type Content
    = ContentHome HomePage.Model
    | ContentBlog BlogPage.Model
    | ContentAbout AboutPage.Model
    | ContentNotFound
    