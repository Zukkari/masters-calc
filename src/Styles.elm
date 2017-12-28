module Styles exposing (..)

import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)


inputField =
    styled input
        [ margin (px 5)
        , Css.height (px 30)
        , fontSize (px 20)
        , hover
            [ borderColor (hex "#ccddff")
            ]
        ]


mainDiv =
    styled div
        [ Css.textAlign center
        , Css.height (vh 100)
        ]


msgDiv =
    styled div
        [ paddingTop (vh 40)
        , paddingBottom (vh 5)
        ]
