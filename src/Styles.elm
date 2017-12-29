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
        , borderRadius (px 7)
        , padding (px 10)
        , fontSize (px 20)
        , borderColor (hex "#ffffff")
        , borderWidth (px 2)
        ]


mainDiv =
    styled div
        [ Css.textAlign center
        , Css.height (vh 100)
        , backgroundImage (url "https://hdwallsource.com/img/2014/9/gradient-background-26046-26731-hd-wallpapers.jpg")
        ]


msgDiv =
    styled div
        [ paddingTop (vh 25)
        , paddingBottom (vh 5)
        , Css.width (vh 60)
        , margin auto
        , Css.height (vh 10)
        ]


inputDiv =
    styled div
        [ margin auto
        , Css.width (vh 40)
        , marginTop (vh 25)
        , borderWidth (px 1)
        , borderStyle solid
        , borderColor (hex ("#ffffff"))
        , borderRadius (px 7)
        , padding (px 20)
        ]


resultMsg positive =
    let
        ( textColor, bgColor ) =
            colors positive
    in
        styled div
            [ paddingBottom (px 30)
            , fontWeight bold
            , fontSize (px 25)
            , color (hex textColor)
            , backgroundColor (hex bgColor)
            , Css.height (vh 10)
            ]


scoreMsg positive =
    let
        ( textColor, bgColor ) =
            colors positive
    in
        styled div
            [ paddingBottom (px 30)
            , fontWeight bold
            , fontSize (px 50)
            , color (hex textColor)
            , backgroundColor (hex bgColor)
            , Css.height (vh 10)
            ]


infoDiv pos =
    let
        ( textColor, bgColor ) =
            colors pos
    in
        styled div
            [ color (hex (textColor))
            , backgroundColor (hex bgColor)
            ]


colors : Bool -> ( String, String )
colors pos =
    if (pos) then
        ( "#009900", "#ccffcc" )
    else
        ( "#cc0000", "#ffb3b3" )


dummyDiv =
    styled div
        [ paddingBottom (px 30)
        , fontWeight bold
        , fontSize (px 25)
        , color (hex "#00000")
        ]


textBox positive =
    let
        ( textColor, bgColor ) =
            colors positive
    in
        styled div
            [ borderWidth (px 1)
            , borderColor (hex (textColor))
            , fontFamilies [ "monospace" ]
            , borderStyle solid
            , Css.height (vh 30)
            , padding (px 20)
            , borderRadius (px 7)
            , backgroundColor (hex bgColor)
            ]


textBoxDummy =
    styled div
        [ borderWidth (px 1)
        , borderColor (hex "#ffffff")
        , color (hex "#ffffff")
        , fontFamilies [ "monospace" ]
        , borderStyle solid
        , Css.height (vh 30)
        , padding (px 20)
        , borderRadius (px 7)
        ]
