#!/bin/bash -e

api="https://artifactory-t.ing.net/artifactory/api/storage"

usage() {
    echo "Set a stage property in Artifactory Pro"
    echo "Usage: $0 targetFolder artefact tag"
    exit 1
}

if [ -z "$2" ]; then
    usage
fi

set +x

if [ -z "$ARTIFACTORY_USER" ]; then
    echo "Ensure you have the environment variables set"
    echo "ARTIFACTORY_USER"
    exit 1
fi

if [ -z "$ARTIFACTORY_PASSWORD" ]; then
    echo "Ensure you have the environment variables set"
    echo "ARTIFACTORY_PASSWORD"
    exit 1
fi
targetFolder="$1"
fileName="$2"
stagingTag="$3"


echo "INFO: Uploading $localFilePath to $targetFolder/$fileName"
curl --fail -k -i -X PUT -u $ARTIFACTORY_USER:$ARTIFACTORY_PASSWORD \
 "$api/$targetFolder/$fileName?properties=stage=$stagingTag"

