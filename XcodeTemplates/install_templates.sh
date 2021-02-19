#!/bin/bash
set -eo pipefail
IFS=$'\n\t'

# Remove all existing files
rm -fR ~/Library/Developer/Xcode/Templates/File\ Templates/VoirCam/

# Create directory
mkdir -p ~/Library/Developer/Xcode/Templates/File\ Templates/VoirCam

# Copy all included templates to the templates directory 
cp -R VoirCam ~/Library/Developer/Xcode/Templates/File\ Templates
