module Model exposing (..)

-- API Return


type alias Config =
    { api_url : String
    , version : String
    }


type alias Model =
    { software : List Software
    , config : Config
    }


type alias Software =
    { id : String
    , name : String
    , website : String
    , licenses : List License
    , latest_version_stable : Version
    , latest_version_unstable : Version
    }


type alias License =
    { spdx_id : String
    , name : String
    }


type alias Version =
    { name : String
    , release_notes_url : String
    }
