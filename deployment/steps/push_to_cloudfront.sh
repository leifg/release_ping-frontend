#!/bin/sh

aws s3 sync --acl public-read build s3://release-ping-assets
