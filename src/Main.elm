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


viewLicenses : List License -> Html Msg
viewLicenses licenses =
    div [] (List.map viewLicense licenses)


viewLicense : License -> Html Msg
viewLicense license =
    span []
        [ a [ href ("https://choosealicense.com/licenses/" ++ (String.toLower license.spdx_id)) ]
            [ text license.name ]
        ]


viewVersion : Version -> Html Msg
viewVersion version =
    a [ href version.release_notes_url ]
        [ text version.name ]


viewSoftware : Software -> Html Msg
viewSoftware software =
    tr []
        [ td [] [ text software.name ]
        , td [] [ viewVersion software.latest_version_stable ]
        , td [] [ viewVersion software.latest_version_unstable ]
        , td [] [ (viewLicenses software.licenses) ]
        ]


viewModel : Model -> Html Msg
viewModel model =
    table
        [ class "uk-table uk-table-striped uk-table-small" ]
        [ thead []
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
    div []
        [ h1 [] [ text "Software" ]
        , viewModel model
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
