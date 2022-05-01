module Omikuji exposing (Model, Msg, init, subscriptions, update, view)

import Html exposing (Html, button, div, p, text)
import Html.Events exposing (onClick)
import Random



-- model


type alias Model =
    { omikuji : Maybe Omikuji
    }


type Omikuji
    = LargeGood
    | MediumGood
    | SmallGood
    | SueGood
    | Bad
    | LargeBad


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model Nothing, Cmd.none )



-- update


type Msg
    = NewOmikuji Omikuji
    | Draw


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Draw ->
            ( model
            , Random.generate NewOmikuji genOmikuji
            )

        NewOmikuji newOmikuji ->
            ( { model | omikuji = Just newOmikuji }
            , Cmd.none
            )


genOmikuji : Random.Generator Omikuji
genOmikuji =
    Random.uniform LargeGood [ MediumGood, SmallGood, SueGood, Bad, LargeBad ]



-- sub


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- view


renderResult : Maybe Omikuji -> String
renderResult result =
    case result of
        Nothing ->
            "何が出るかな"

        Just omikuji ->
            renderOmikuji omikuji


renderOmikuji : Omikuji -> String
renderOmikuji omikuji =
    case omikuji of
        LargeGood ->
            "大吉"

        MediumGood ->
            "中吉"

        SmallGood ->
            "小吉"

        SueGood ->
            "末吉"

        Bad ->
            "凶"

        LargeBad ->
            "大凶"


view : Model -> Html Msg
view model =
    div []
        [ p [] [ text <| renderResult model.omikuji ]
        , button [ onClick Draw ] [ text "Draw" ]
        ]
