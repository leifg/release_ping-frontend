#!/bin/sh

# Push to S3 bucket
aws s3 sync --acl public-read build s3://release-ping-assets

# Invalidate Cache
aws cloudfront create-invalidation --distribution-id ${AWS_CF_DISTRIBUTION_ID} --paths /index.html