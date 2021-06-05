#!/bin/bash

SCRIPT_DIR="$(dirname $_)"
swift run --package-path "$SCRIPT_DIR/swish-scripts" appstore $SCRIPT_DIR $@
