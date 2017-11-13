module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)
import Json.Decode exposing (..)
import Http


---- MODEL ----


initialModel : Config -> Model
initialModel config =
    { software = []
    , config = config
    }


init : Config -> ( Model, Cmd Msg )
init config =
    ( initialModel config, (fetchSoftware config.api_url) )



---- UPDATE ----


type Msg
    = LoadSoftware (Result Http.Error (List Software))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadSoftware (Ok software) ->
            ( { model | software = software }, Cmd.none )

        LoadSoftware (Err error) ->
            let
                _ =
                    Debug.log "Oops!" error
            in
                ( model, Cmd.none )



---- VIEW ----


viewLicenses : List License -> Html Msg
viewLicenses licenses =
    div [] (List.map viewLicense licenses)


viewLicense : License -> Html Msg
viewLicense license =
    span []
        [ a [ href ("https://choosealicense.com/licenses/" ++ (String.toLower license.spdx_id)), target "_blank" ]
            [ text license.name ]
        ]


viewSoftwareName : Software -> Html Msg
viewSoftwareName software =
    span []
        [ a [ href software.website, target "_blank" ]
            [ text software.name ]
        ]


viewVersion : Version -> Html Msg
viewVersion version =
    a [ href version.release_notes_url, target "_blank" ]
        [ text version.name ]


viewSoftware : Software -> Html Msg
viewSoftware software =
    tr []
        [ td [] [ viewSoftwareName software ]
        , td [] [ viewVersion software.latest_version_stable ]
        , td [] [ viewVersion software.latest_version_unstable ]
        , td [] [ (viewLicenses software.licenses) ]
        ]


viewModel : Model -> Html Msg
viewModel model =
    div []
        [ viewSoftwareTable model
        , viewAppVersion model.config
        ]


viewAppVersion : Config -> Html Msg
viewAppVersion config =
    div [ class "uk-text-small uk-text-muted uk-position-small uk-position-bottom-right", id "appVersion" ]
        [ text config.version ]


viewSoftwareTable : Model -> Html Msg
viewSoftwareTable model =
    table [ class "uk-table uk-table-striped uk-table-small" ]
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



---- COMMANDS ----


fetchSoftware : String -> Cmd Msg
fetchSoftware apiUrl =
    Json.Decode.list softwareDecoder
        |> Http.get (apiUrl ++ "/software")
        |> Http.send LoadSoftware



---- DECODER ----


softwareDecoder : Decoder Software
softwareDecoder =
    map6 Software idDecoder nameDecoder websiteDecoder licensesDecoder (versionDecoder "latest_version_stable") (versionDecoder "latest_version_unstable")


idDecoder : Decoder String
idDecoder =
    field "id" string


nameDecoder : Decoder String
nameDecoder =
    field "name" string


spdxIdDecoder : Decoder String
spdxIdDecoder =
    field "spdx_id" string


websiteDecoder : Decoder String
websiteDecoder =
    field "website" string


releaseNotesUrlDecoder : Decoder String
releaseNotesUrlDecoder =
    field "release_notes_url" string


versionDecoder : String -> Decoder Version
versionDecoder fieldName =
    field fieldName
        (map2 Version nameDecoder releaseNotesUrlDecoder)


licensesDecoder : Decoder (List License)
licensesDecoder =
    field "licenses" (Json.Decode.list licenseDecoder)


licenseDecoder : Decoder License
licenseDecoder =
    map2 License spdxIdDecoder nameDecoder



---- PROGRAM ----


main : Program Config Model Msg
main =
    Html.programWithFlags
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
