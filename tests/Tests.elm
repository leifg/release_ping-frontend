module Tests exposing (..)

import Test exposing (..)
import Fake exposing (elixir, erlang)
import Expect
import String


all : Test
all =
    let
        elixir =
            Fake.elixir

        erlang =
            Fake.erlang
    in
        describe "Fake Model"
            [ test "Elixir" <|
                \_ ->
                    Expect.equal "Elixir" elixir.name
            , test "Erlang" <|
                \_ ->
                    Expect.equal "Erlang" erlang.name
            ]
