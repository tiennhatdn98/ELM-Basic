module Test exposing (..)

import Browser
import Html exposing (div, text, input, button)
import Html.Events exposing (onClick, onInput)
import String exposing (fromInt, toInt)
import Debug exposing (log)

type Messages = 
  Add
  | Change String

init = 
  { 
    value = 52
    , number = 0
  }

view model =
  div [] [
    text (fromInt model.value)
    , div [] []
    , input [ onInput Change ] []
    , button [ onClick Add ] [ text "Add" ]
    ]

add a b = a + b

parseNumber text =
  let
    number = toInt text
  in
    case number of
      Just val ->
        val
      Nothing ->
        0

update msg model = 
  let
    log1 = log "msg" msg
    log2 = log "model" model
  in
  case msg of 
    Add -> 
      { value = model.value + model.number }
    Change events ->
      { number = parseNumber events }

main = 
  Browser.sandbox({ init = init, view = view, update = update })