module Main exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--

import Browser
import Html exposing (Html, button, div, text, input)
import Html.Events exposing (onClick)

-- MAIN

main =
  Browser.sandbox { init = init, update = update, view = view }
  
-- MODEL

type alias Model = Int

init : Model
init =
  0
gretting = 
  ""

-- UPDATE

type Msg
  = Increment
  | Decrement

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 3

    Decrement ->
      model - 3

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ 
      div [] 
        [
          input [ placeholder "Ahihi" ] [  ]
        ]
      , button [ onClick Decrement ] [ text "-" ]
      , div [] [ text (String.fromInt model) ]
      , button [ onClick Increment ] [ text "+" ]
    ]