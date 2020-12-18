#!/bin/bash
echo "Activating Anaconda build env"
source ~/anaconda3/etc/profile.d/conda.sh

while [ "$1" != "" ]; do
    case $1 in
        -r | --Github_Run_Id        )   shift
                                        GITHUB_RUN_ID=$1
                                        ;;
        -rn | --Github_Run_Number   )   shift
                                        GITHUB_RUN_NUMBER=$1
                                        ;;
        -c | --create,remove        )   shift
                                        CREATE=$1
                                        ;;
        -h | --help                 )   usage
                                        exit 1
    esac
    shift
done

buildName=$GITHUB_RUN_ID-$GITHUB_RUN_NUMBER

if [ "$CREATE" == "TRUE" ];
then
    echo "Creating build $buildName env"
    conda create -n $buildName python=3.7
    echo "::set-output name=buildName::$(echo $buildName)"
else
    echo "Removing build $buildName env"
    conda env remove -n $buildName
fi
