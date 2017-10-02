#!/bin/sh

set -e

base_dir=$(dirname $0)

if [ ! -f .version ]; then
  echo "No version change, skip deployment"
else
  VERSION=$(cat .version)
  echo "Replace Version"
  ${base_dir}/steps/replace_version.sh ${VERSION}

  echo "Build App"
  ${base_dir}/steps/build_app.sh

  echo "Push to Cloudfront"
  ${base_dir}/steps/push_to_cloudfront.sh
fi
