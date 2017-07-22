#!/bin/sh
set -ex

. ./bin/setup.sh

# FIXME: Always run Darwin recipe.
bin/mitamae local --node-json nodes/darwin.json roles/darwin.rb
