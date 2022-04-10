module Textfield exposing (..)

import Browser
import Html exposing (Html, Attribute, button, div, text, span, input)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (..)
import String exposing (..)
import Debug exposing (log)

-- MAIN
main =
  Browser.sandbox { init = init, update = update, view = view }

-- MODEL
type alias Model = 
  { content: String
    , value: Int
    , result: Int
    , number: Int
  } 

init : Model
init = 
  Model "" 0 0 0
-- init = 
--   { content = ""
--     , value = 0
--     , result = 0
--     , number = 0
--   }

-- UPDATE
type Msg
  = Reverse String
  | ChangeNumber String
  | Add
  | Increment
  | Decrement

parseNumber text =
  let
    number = toInt text
  in
  case number of
    Just val ->
      val
    Nothing ->
      0

-- update : Msg -> Model -> Model
update msg model =
  case msg of
    Reverse text ->
      let 
        log1 = log "text" text
      in
      { model | content = String.reverse text }
      
    ChangeNumber number ->
      { model | number = parseNumber number }
    
    Add ->
      { model | result = model.value + model.number }
    
    Increment ->
      { model | value = model.value + 1 }
      
    Decrement ->
      { model | value = model.value - 1 }

-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ input [ placeholder "Enter text", onInput Reverse ] []
      , div [] [ text ("Reverse text: " ++ model.content) ]
      , div [] 
        [ text ("Value: " ++ (fromInt model.value)) 
          , button [ onClick Increment ] [ text "+"]
          , button [ onClick Decrement ] [ text "-"]
        ]
      , input [ placeholder "Enter number", value (fromInt model.number), onInput ChangeNumber ] []
      , button [ onClick Add ] [ text "Add" ]
      , div [] [ text (fromInt model.result) ] 
    ]