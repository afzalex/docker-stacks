#!/bin/bash

rm -rf .build
mkdir -p .build/conf.d
mkdir -p .build/locations
cp -rf conf.d/ .build/conf.d/
cp -rf locations/ .build/locations/
export FZNGINX_HOST=$(hostname)
(ls -1 .build/conf.d/*.tpl && ls -1 .build/locations/*.tpl) | while read file; do
  export FZNGINX_SITE=$(basename "$file" | cut -d '.' -f 1)
  outfile=${file%.tpl}
  envsubst '
    $FZNGINX_HOST
    $FZNGINX_SITE
  ' < ${file} > $outfile
  rm $file
done
