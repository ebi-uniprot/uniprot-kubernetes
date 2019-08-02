#!/bin/bash
 
bucket=$1
file=$2
 
# usage: ./minio-upload my-bucket my-file.zip
 
host="193.62.55.83:30099"
minio_key=""
minio_secret=""
 
content_type="application/octet-stream"
resource="/${bucket}/${file}"
date=`date -R`
_signature="PUT\n\n${content_type}\n${date}\n${resource}"
signature=`echo -en ${_signature} | openssl sha1 -hmac ${minio_secret} -binary | base64`
 
curl -v -X PUT -T "${file}" \
          -H "Host: $host" \
          -H "Date: ${date}" \
          -H "Content-Type: ${content_type}" \
          -H "Authorization: AWS ${minio_key}:${signature}" \
http://$host${resource}

