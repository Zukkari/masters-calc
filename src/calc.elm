module Main exposing (..)

import Html exposing (..)


main =
    Html.program { init = init, view = view, update = update, subscriptions = subscriptions }


type alias Model =
    { gpa : Float
    , points : Int
    , message : String
    , score : Int
    }



-- MODEL


init : ( Model, Cmd Msg )
init =
    ( Model 0.0 0 "" 0, Cmd.none )



-- UPDATE


type Msg
    = UpdateGPA Float
    | UpdatePoints Int
    | UpdateMessage


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateGPA newGPA ->
            ( { model | gpa = newGPA }, Cmd.none )

        UpdatePoints newPoints ->
            ( { model | points = newPoints }, Cmd.none )

        UpdateMessage ->
            ( updateMsg model, Cmd.none )


updateMsg : Model -> Model
updateMsg { gpa, points, message, score } =
    let
        sc =
            (gpa / 5) * 100 * 0.6 + points * 0.4

        updatedModel =
            setMsg Model gpa points message sc
    in
        { updatedModel | score = sc }



-- Max possible grade


maxGrade =
    5


passingPoints =
    51


minimumAllowedScore =
    66


setMsg : Model -> Model
setMsg model =
    let
        nonScaledGPA =
            (model.gpa / maxGrade) * 100

        msg =
            if (model.points < passingPoints) then
                "You need to have " + toString passingPoints + " points or more for motivation letter in order to pass"
            else if (nonScaledGPA < passingPoints) then
                "Your GPA needs to be at least" + toString ((passingPoints / 100) * maxGrade) + " in order to get admitted"
            else if (model.score < minimumAllowedScore) then
                "You need at least " + minimumAllowedScore + " points in total in order to get admitted"
            else
                "You are good to go!"
    in
        { model | message = msg }



-- VIEW


view : Model -> Html Msg
view model =
    div [] []



--SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
