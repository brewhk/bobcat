#!/usr/bin/env bash

# If there is an error, abort the script
set -e

# Creates the meteor package
meteor create --package $1

# Meteor do not use the vendor prefix
name=$(sed 's/.*://g' <<< $1)
cd packages/$name;

# Disable history expansion
set +H

# Enable Bash Extended Globbing
shopt -s extglob

# Remove all files except package.js and README.md
rm !(package.js|README.md)

# Re-enable history expansion
set -H

# Create the directory structure that we want
mkdir -p client/api client/ui/components client/ui/pages client/ui/layouts lib/ server/
touch lib/main.js
echo "import '../lib/main.js';" > client/main.js
echo "import '../lib/main.js';" > server/main.js

# Remove the onTest block
sed -i -n '/Package.onTest/q;p' package.js

# Replace the api.mainModule line to include two entry points - one for client, one for server
sed -i $'s/api.mainModule(.*/api.mainModule(\'client\/main.js\', \'client\');\\\n  api.mainModule(\'server\/main.js\', \'server\');/g' package.js