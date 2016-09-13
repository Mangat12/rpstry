#!/bin/bash

set -e # Fail fast

DISTRIBUTION_ID=E24IX12YGBOCSM
BUCKET_NAME=ateamdaily.com-cdn

# Build a fresh copy
hugo -v 

# Copy over pages - not static js/img/css/downloads
aws s3 sync --acl "public-read" --sse "AES256" public/ s3://$BUCKET_NAME --exclude 'post'

# Invalidate root page and page listings
aws cloudfront create-invalidation --distribution-id $DISTRIBUTION_ID --paths /index.html / /page/*

