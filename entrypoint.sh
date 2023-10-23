#!/bin/sh

if [ "$1" == "lambda/handlers.handler" ]; then
    export _HANDLER="$1"
    RUNTIME_ENTRYPOINT=/var/runtime/bootstrap
    if [ -z "${AWS_LAMBDA_RUNTIME_API}" ]; then
        watchexec --poll 100 -e py -r /usr/local/bin/aws-lambda-rie ${RUNTIME_ENTRYPOINT}
    else
        exec ${RUNTIME_ENTRYPOINT}
    fi
else
    echo "incorrect run parameter" 1>&2
    exit 142
fi


