#!/bin/bash

__kube_ps1()
{
    # Get current context
    CONTEXT=$(kubectl config current-context)

    if [[ -n "$CONTEXT" ]]; then
        echo -n -e "(k8s: $CONTEXT)"
    fi
}
