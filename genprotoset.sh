#!/usr/bin/env bash
#

set -e
set -u

PROTOC_BIN=${PROTOC_BIN:-protoc}

PARCA_DIRS="debuginfo metastore profilestore query scrape share telemetry"

PROTO_FILES="proto/google/pprof/*.proto"

for dir in ${PARCA_DIRS}; do
  PROTO_FILES=${PROTO_FILES}" proto/parca/"${dir}"/v1alpha1/*.proto"
done

${PROTOC_BIN} \
  -I=tmp \
  -I=proto \
  --include_imports \
  -oparca.protoset \
  --experimental_allow_proto3_optional \
  ${PROTO_FILES}