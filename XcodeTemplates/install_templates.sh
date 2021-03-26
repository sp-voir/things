#!/bin/bash
set -eo pipefail
IFS=$'\n\t'

# Remove all existing files
rm -fR ~/Library/Developer/Xcode/Templates/File\ Templates/Things/

# Create directory
mkdir -p ~/Library/Developer/Xcode/Templates/File\ Templates/Things

# Copy all included templates to the templates directory 
cp -R Things ~/Library/Developer/Xcode/Templates/File\ Templates
