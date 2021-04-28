#!/usr/bin/env bash

# Create a folder and move into it in one command
# -------------------
mcd() { mkdir -p "$@" && cd "$_" || return; }
