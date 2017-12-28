module Main exposing (main)

import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, placeholder, src)
import Html.Styled.Events exposing (onClick, onInput)
import MessageUpdate exposing (Model, updateScore, positiveMsg)
import String exposing (toInt)
import Json.Decode as Decode
import Styles exposing (inputField, mainDiv, msgDiv)


main =
    Html.program { init = init, view = view >> toUnstyled, update = update, subscriptions = subscriptions }



-- MODEL


init : ( Model, Cmd Msg )
init =
    ( Model 0.0 0 "" 0 5.0 51 66, Cmd.none )



-- UPDATE


type Msg
    = UpdateGPA String
    | UpdatePoints String
    | UpdateMessage


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateGPA newGPA ->
            let
                converted =
                    case String.toFloat newGPA of
                        Err msg ->
                            0.0

                        Ok value ->
                            if (value <= model.maxGrade) then
                                value
                            else
                                model.maxGrade

                updatedModel =
                    { model | gpa = converted }
            in
                update UpdateMessage updatedModel

        UpdatePoints newPoints ->
            let
                newValue =
                    case toInt newPoints of
                        Err _ ->
                            0

                        Ok val ->
                            if (val <= 100) then
                                val
                            else
                                100

                updatedModel =
                    { model | points = newValue }
            in
                update UpdateMessage updatedModel

        UpdateMessage ->
            ( updateScore model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    mainDiv []
        [ msgDiv [] [ formMessage model ]
        , div [] [ formInputField "Enter your GPA" UpdateGPA ]
        , div [] [ formInputField "Enter score for motivation letter" UpdatePoints ]
        ]


formMessage : Model -> Html Msg
formMessage model =
    let
        msg =
            model.message
    in
        if msg /= "" && model.score > 0 && model.gpa > 0.0 && model.points > 0 then
            div []
                [ div [] [ text model.message ]
                , formDetailedMsg model
                ]
        else
            div [] []


formDetailedMsg : Model -> Html Msg
formDetailedMsg model =
    div []
        [ div [] [ text ("Your GPA is " ++ toString model.gpa ++ " out of " ++ toString model.maxGrade) ]
        , div [] [ text ("Your motivation letter score is " ++ toString model.points ++ " out of possible 100") ]
        , div []
            [ text ("Your total score is " ++ toString model.score ++ " and you need " ++ toString model.minimumAllowedScore ++ " to get admitted")
            ]
        ]


formInputField dummy action =
    inputField [ placeholder dummy, onInput action ] []


msgColor : String -> String
msgColor msg =
    if msg == positiveMsg then
        "green"
    else
        "red"



--SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
