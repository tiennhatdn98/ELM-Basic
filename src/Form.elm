module Form exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import String exposing (..)
import Char exposing (..)
import Debug exposing (..)

-- MAIN
main =  
  Browser.sandbox({ init = init, update = update, view = view })

-- MODEL
type Validation = 
  None
  | OK
  | Error String

type alias Model =
  { username : String
    , password : String
    , passwordAgain: String
    , valid : Validation
  }

init : Model
init =
  Model "" "" "" None

-- UPDATE
type Msg =
  Username String
  | Password String
  | PasswordAgain String
  | Check

update : Msg -> Model -> Model
update msg model =
  let 
    log1 = log "msg" msg
    log2 = log "model" model
  in
  case msg of
    Username username ->
      { model | username = username }

    Password password ->
      { model | password = password }

    PasswordAgain passwordAgain -> 
      { model | passwordAgain = passwordAgain }

    Check ->
      { model | valid = validate model }

validate : Model -> Validation
validate model =
  if String.length model.username == 0 then Error "Please enter a username"
  else if String.length model.password == 0 then Error "Please enter a password"
  else if String.length model.passwordAgain == 0 then Error "Please enter confirm password"
  else if (String.any isDigit model.password) || (String.any isDigit model.passwordAgain) then Error "Password is less than or equal 8 characters"
  else if model.password /= model.passwordAgain then Error "Passwords do not match"
  else OK

-- VIEW
view : Model -> Html Msg
view model =
  div [] 
    [ viewInput "text" "Enter username" model.username Username 
      , viewInput "password" "Enter password" model.password Password
      , viewInput "password" "Enter confirm password" model.passwordAgain PasswordAgain
      , button [ onClick Check ] [ text "Submit" ]
      , viewValidation model
    ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v onMsg =
  div [] [  
    input [ type_ t, placeholder p, value v, onInput onMsg ] []
  ]

viewValidation model =
  case model.valid of
    None ->
      div [ style "color" "black" ] [ text "Please enter your information" ]
    OK ->
      div [ style "color" "green" ] [ text "OK" ]
    Error error ->
      div [ style "color" "red" ] [ text error ]
    