#!/bin/bash
echo "Activating Anaconda build env"
source ~/anaconda3/etc/profile.d/conda.sh
set -x

domain=$1
domain_owner=$2
repository=$3
aws_access_key=$4
aws_access_secret=$5
local_path=$6
GITHUB_RUN_ID=$7
GITHUB_RUN_NUMBER=$8

export AWS_ACCESS_KEY_ID=$aws_access_key
export AWS_SECRET_ACCESS_KEY=$aws_access_secret
export AWS_DEFAULT_REGION=us-east-1

echo $(which python)
buildName=$GITHUB_RUN_ID-$GITHUB_RUN_NUMBER
conda activate $buildName
echo Activated release env $buildName

# Configure twine to work with AWS Code Artifcats
aws codeartifact login --tool twine --domain $domain --domain-owner $domain_owner --repository $repository --region us-east-1

# Upload built package
twine upload --repository codeartifact $local_path
