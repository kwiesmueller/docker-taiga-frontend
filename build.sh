#!/bin/sh

CONTENT_LENGTH="$(stat -f%z cloudbuild.json)"
ACCESS_TOKEN="$(gcloud auth print-access-token)"

curl -v -X POST -T cloudbuild.json -H "Content-Type: application/json" \
                                             -H "Content-length: ${CONTENT_LENGTH}" \
                                             -H "Authorization: Bearer ${ACCESS_TOKEN}" \
                                             https://cloudbuild.googleapis.com/v1/projects/playnet-gce/builds
