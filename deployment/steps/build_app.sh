#!/bin/sh

ELM_APP_VERSION=$(jq -r ".version" elm-package.json) elm-app build
