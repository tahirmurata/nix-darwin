#!/bin/bash

# Check if full disk access is enabled
if [[ -r "/Library/Application Support/com.apple.TCC/TCC.db" ]]; then
  echo "Full Disk Access is enabled for the Terminal."
  # Install command line tools
  xcode-select --install

  # Install Rosetta 2
  softwareupdate --install-rosetta --agree-to-license

  # Install Lix
  curl -sSf -L https://install.lix.systems/lix | sh -s -- install
else
  echo "Full Disk Access is NOT enabled for the Terminal."
  echo "Please enable Full Disk Access for Terminal in System Preferences."
  return 1
fi
