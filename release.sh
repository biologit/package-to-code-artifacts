#!/bin/bash

domain=$1
domain_owner=$2
repository=$3
local_path=$4
region=$5

# Configure twine to work with AWS Code Artifcats
aws codeartifact login --tool twine --domain $domain --domain-owner $domain_owner --repository $repository --region $region

# Upload built package
twine upload --repository codeartifact $local_path
