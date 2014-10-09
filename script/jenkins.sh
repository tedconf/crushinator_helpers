#!/bin/bash
#
# Shell script to be invoked by Jenkins
#
# This will setup the environment, run the tests, and exit with the
# appropriate status.
#

# Setup our ruby and gemset
test -e /usr/local/rvm/scripts/rvm && source /usr/local/rvm/scripts/rvm
type rvm | head -1

# Exit immediately if any single command fails
set -e

# Use our gemset (create it if it doesn't already exist)
ruby_version='2.1.2'
ruby_gemset='crushinator_helpers'

rvm use ${ruby_version}@${ruby_gemset}

# Print all commands after expansion.  Note that you can put this earlier
# in the script, but rvm prints out a wall-o-text.
set -x

# Update all our gems
bundle install

# build code coverage reports and xml reports of which tests fail
export COVERAGE=on

# Run the tests
bundle exec rake spec

exit 0
