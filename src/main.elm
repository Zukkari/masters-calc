module Main exposing (..)

import Html exposing (..)
import MessageUpdate exposing (Model, updateScore)


main =
    Html.program { init = init, view = view, update = update, subscriptions = subscriptions }



-- MODEL


init : ( Model, Cmd Msg )
init =
    ( Model 0.0 0 "" 0 5.0 51 66, Cmd.none )



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
            ( updateScore model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div [] []



--SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
