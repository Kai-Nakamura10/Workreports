#!/usr/bin/env bash

set -o errexit
bin/rails assets:precompile

bin/rails db:migrate
bundle exec rails db:migrate DATABASE=queue
bundle exec rails db:migrate DATABASE=cache
bundle exec rails db:migrate DATABASE=cable