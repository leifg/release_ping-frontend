module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)
import Fake exposing (..)


---- MODEL ----


initialModel : Model
initialModel =
    { software = [ Fake.elixir, Fake.erlang ] }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


viewLicense : License -> String
viewLicense license =
    license.name


viewSoftware : Software -> Html Msg
viewSoftware software =
    tr []
        [ td [] [ text software.name ]
        , td [] [ text software.latest_version_stable.name ]
        , td [] [ text software.latest_version_unstable.name ]
        , td [] [ text (String.join ", " (List.map viewLicense software.licenses)) ]
        ]


viewModel : Model -> Html Msg
viewModel model =
    table
        [ class "uk-table" ]
        [ caption [] [ text "Software" ]
        , thead []
            [ tr []
                [ th [] [ text "Name" ]
                , th [] [ text "Latest Version Stable" ]
                , th [] [ text "Latest Version Unstable" ]
                , th [] [ text "Licenses" ]
                ]
            ]
        , tbody []
            (List.map
                viewSoftware
                model.software
            )
        ]


view : Model -> Html Msg
view model =
    div [] [ viewModel model ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
