#!/bin/sh

~/go/bin/reflex -r '\.go' -s -- sh -c 'go test -v ./...'
