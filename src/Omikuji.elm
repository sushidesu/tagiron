module Omikuji exposing (..)

import Html exposing (Html, button, div, p, text)
import Html.Events exposing (onClick)
import Random



-- model


type alias Model =
    { omikuji : Result
    }


type Result
    = HasValue Omikuji
    | None


type Omikuji
    = LargeGood
    | MediumGood
    | SmallGood
    | SueGood
    | Bad
    | LargeBad


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model None, Cmd.none )



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
            ( { model | omikuji = HasValue newOmikuji }
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


renderResult : Result -> String
renderResult result =
    case result of
        None ->
            "何が出るかな"

        HasValue omikuji ->
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
        [ p [] [ model.omikuji |> renderResult |> text ]
        , button [ onClick Draw ] [ text "Draw" ]
        ]
