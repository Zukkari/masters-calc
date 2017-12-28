module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (placeholder, style)
import Html.Events exposing (onClick, onInput)
import MessageUpdate exposing (Model, updateScore, positiveMsg)
import String exposing (toInt)
import Json.Decode as Decode


main =
    Html.program { init = init, view = view, update = update, subscriptions = subscriptions }



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
                            model.gpa

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
                            model.points

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
    div []
        [ div [] [ formMessage model ]
        , div [] [ formInputField "Enter your GPA e.g. 5.0" UpdateGPA ]
        , div [] [ formInputField "Enter score for motivation letter" UpdatePoints ]
        , button [ onClick UpdateMessage ] [ text "Calculate score!" ]
        ]


formMessage : Model -> Html Msg
formMessage model =
    let
        msg =
            model.message
    in
        if msg /= "" && model.score > 0 && model.gpa > 0.0 && model.points > 0 then
            div []
                [ div [ style [ ( "color", msgColor msg ) ] ] [ text model.message ]
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
    input [ placeholder dummy, onInput action ] []


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
