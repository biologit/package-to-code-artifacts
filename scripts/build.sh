#!/bin/bash
echo "Activating Anaconda build env"
source ~/anaconda3/etc/profile.d/conda.sh
set -x

GITHUB_RUN_ID=$1
GITHUB_RUN_NUMBER=$2

echo $(which python)
buildName=$GITHUB_RUN_ID-$GITHUB_RUN_NUMBER
conda activate $buildName
echo Activated release env $buildName

# Configure pip to work with AWS Code Artifcats
aws codeartifact login --tool pip --domain $domain --domain-owner $domain_owner --repository $repository --region us-east-1

# Install required dependencies for Python script.
pip install -e .[release]
python setup.py sdist bdist_wheel