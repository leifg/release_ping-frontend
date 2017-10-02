#!/bin/sh

set -e

new_version=${1}

jq ".version |= \"${new_version}\"" elm-package.json | sponge elm-package.json

