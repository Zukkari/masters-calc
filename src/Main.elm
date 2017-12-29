module Main exposing (main)

import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, placeholder, value, src)
import Html.Styled.Events exposing (onClick, onInput)
import MessageUpdate exposing (Model, updateScore)
import String exposing (toInt)
import Styles exposing (configDiv, dummyDiv, infoDiv, inputDiv, inputField, mainDiv, msgDiv, resultMsg, scoreMsg, textBox, textBoxDummy)


main =
    Html.program { init = init, view = view >> toUnstyled, update = update, subscriptions = subscriptions }



-- MODEL


init : ( Model, Cmd Msg )
init =
    ( Model 0.0 0 "" 0 5.0 51 66 40 60 False, Cmd.none )



-- UPDATE


type Msg
    = UpdateGPA String
    | UpdatePoints String
    | UpdateMessage
    | UpdateLetterWeight String
    | UpdateGPAWeight String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateGPA newGPA ->
            let
                converted =
                    parseFloat newGPA 0.0

                res =
                    if (converted <= model.maxGrade) then
                        converted
                    else
                        model.maxGrade

                updatedModel =
                    { model | gpa = res }
            in
                update UpdateMessage updatedModel

        UpdatePoints newPoints ->
            let
                newValue =
                    parseInt newPoints 0

                res =
                    if (newValue <= 100) then
                        newValue
                    else
                        100

                updatedModel =
                    { model | points = res }
            in
                update UpdateMessage updatedModel

        UpdateLetterWeight w ->
            let
                newValue =
                    parseInt w 0

                corr =
                    if (newValue > 100) then
                        100
                    else if (newValue < 0) then
                        0
                    else
                        newValue
            in
                update UpdateMessage { model | letterWeight = corr, gpaWeight = 100 - corr }

        UpdateGPAWeight w ->
            let
                newValue =
                    parseInt w 0

                corr =
                    if (newValue > 100) then
                        100
                    else if (newValue < 0) then
                        0
                    else
                        newValue
            in
                update UpdateMessage { model | gpaWeight = corr, letterWeight = 100 - corr }

        UpdateMessage ->
            ( updateScore model, Cmd.none )


parseInt : String -> Int -> Int
parseInt str err =
    case toInt str of
        Err _ ->
            err

        Ok val ->
            val


parseFloat : String -> Float -> Float
parseFloat str err =
    case String.toFloat str of
        Err msg ->
            err

        Ok value ->
            value



-- VIEW


view : Model -> Html Msg
view model =
    mainDiv []
        [ msgDiv [] [ formMessage model ]
        , inputDiv []
            [ div [] [ formInputField "Enter your GPA" UpdateGPA ]
            , div [] [ formInputField "Enter score for motivation letter" UpdatePoints ]
            ]
        , formConfigDiv model
        ]


formConfigDiv : Model -> Html Msg
formConfigDiv model =
    configDiv []
        [ div []
            [ text "GPA weight (%)"
            , formInputFieldWithDefault (toString model.gpaWeight)
                "Enter GPA weight"
                UpdateGPAWeight
            ]
        , div []
            [ text "Letter weight (%)"
            , formInputFieldWithDefault (toString model.letterWeight)
                "Enter letter weight"
                UpdateLetterWeight
            ]
        ]


formMessage : Model -> Html Msg
formMessage model =
    let
        msg =
            model.message
    in
        if msg /= "" && model.score > 0 && model.gpa > 0.0 && model.points > 0 then
            textBox model.positive
                []
                [ resultMsg model.positive
                    []
                    [ text model.message ]
                , scoreMsg
                    model.positive
                    []
                    [ text (toString model.score) ]
                , formDetailedMsg model
                ]
        else
            textBoxDummy [] [ dummyDiv [] [ text "Enter something!" ] ]


formDetailedMsg : Model -> Html Msg
formDetailedMsg model =
    infoDiv model.positive
        []
        [ div [] [ text ("Your GPA is " ++ toString model.gpa ++ " out of " ++ toString model.maxGrade) ]
        , div [] [ text ("Your motivation letter score is " ++ toString model.points ++ " out of possible 100") ]
        , div []
            [ text ("Your total score is " ++ toString model.score ++ " and you need " ++ toString model.minimumAllowedScore ++ " to get admitted")
            ]
        ]


formInputField dummy action =
    inputField [ placeholder dummy, onInput action ] []


formInputFieldWithDefault default dummy action =
    inputField [ value default, placeholder dummy, onInput action ] []


msgColor : Bool -> String
msgColor msg =
    if msg then
        "green"
    else
        "red"



--SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
