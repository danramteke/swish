#!/bin/bash

SCRIPT_DIR="$(dirname $_)"
swift run --package-path "$SCRIPT_DIR" DockerDev $1
