module Fake exposing (elixir, erlang)

import Model exposing (..)


elixir : Software
elixir =
    { id = "6ebb9c14-6848-471f-a7df-e542d20198bc"
    , name = "Elixir"
    , website = "https://elixir-lang.org"
    , latest_version_stable =
        { name = "1.5.1"
        , release_notes_url = "https://github.com/elixir-lang/elixir/releases/tag/v1.5.1"
        }
    , latest_version_unstable =
        { name = "1.5.1"
        , release_notes_url = "https://github.com/elixir-lang/elixir/releases/tag/v1.5.1"
        }
    , licenses = [ apache_license ]
    }


erlang : Software
erlang =
    { id = "308a15b7-4157-4e34-aca9-b7e0412f636b"
    , name = "Erlang"
    , website = "https://erlang.org"
    , latest_version_stable =
        { name = "20.0.4"
        , release_notes_url = "https://github.com/erlang/otp/releases/tag/OTP-20.0.4"
        }
    , latest_version_unstable =
        { name = "20.0.4"
        , release_notes_url = "https://github.com/erlang/otp/releases/tag/OTP-20.0.4"
        }
    , licenses = [ apache_license ]
    }


apache_license : License
apache_license =
    { spdx_id = "Apache-2.0"
    , name = "Apache License 2.0"
    }


mit_license : License
mit_license =
    { spdx_id = "MIT"
    , name = "MIT License"
    }
