module MessageUpdate exposing (..)


type alias Model =
    { gpa : Float
    , points : Int
    , message : String
    , score : Int
    , maxGrade : Float
    , passingPoints : Int
    , minimumAllowedScore : Int
    , positive : Bool
    }


updateScore : Model -> Model
updateScore model =
    let
        sc =
            round ((model.gpa / 5) * 100 * 0.6 + (toFloat model.points) * 0.4)

        updatedModel =
            updateMsg { model | score = sc }
    in
        { updatedModel | score = sc }


updateMsg : Model -> Model
updateMsg model =
    let
        nonScaledGPA =
            (model.gpa / model.maxGrade) * 100

        points =
            toFloat model.passingPoints

        ( msg, feedBack ) =
            if (model.points < model.passingPoints) then
                ( "You need to have >= " ++ toString points ++ " points for motivation letter in order to pass", False )
            else if (nonScaledGPA < points) then
                ( "Your GPA has to be at least " ++ toString ((points / 100) * model.maxGrade) ++ " in order to get admitted", False )
            else if (model.score < model.minimumAllowedScore) then
                ( "You need at least " ++ toString model.minimumAllowedScore ++ " points in total in order to get admitted", False )
            else
                ( "You are good to go!", True )
    in
        { model | message = msg, positive = feedBack }
