#!/bin/bash
set -e

cd dump.d/ || (echo 'There is no dump.d/ directory' && exit 1)

ROLES_FILENAME="roles.dump"
YOSTAGING_CLEANED_FILENAME="yostaging_cleaned.dump"
BIZCENTER_FILENAME="bizcenter.dump"

echo "Initializing ${ROLES_FILENAME}"
rm -f "${ROLES_FILENAME}"
curl -L "https://s3.ap-northeast-2.amazonaws.com/dev.localenv/db/yogiyo/roles_20190718.dump" \
     -o "${ROLES_FILENAME}"

echo "Initializing ${YOSTAGING_CLEANED_FILENAME}"
rm -f "${YOSTAGING_CLEANED_FILENAME}"
curl -L "https://s3.ap-northeast-2.amazonaws.com/dev.localenv/db/yogiyo/yostaging_cleaned_2019_07_22.dump" \
     -o "${YOSTAGING_CLEANED_FILENAME}"

echo "Initializing ${BIZCENTER_FILENAME}"
rm -f "${BIZCENTER_FILENAME}"
curl -L "https://s3.ap-northeast-2.amazonaws.com/dev.localenv/db/bizcenter/bizcenter_20180808.dump" \
     -o "${BIZCENTER_FILENAME}"
