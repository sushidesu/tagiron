module Main exposing (..)

import Browser
import Omikuji exposing (init, subscriptions, update, view)


main : Program () Omikuji.Model Omikuji.Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
