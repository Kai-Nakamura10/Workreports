#!/usr/bin/env bash

set -o errexit
bundle install
bin/rails assets:precompile
bin/rails assets:clean

bin/rails db:migrate
bundle exec rails db:migrate DATABASE=queue
bundle exec rails db:migrate DATABASE=cache
bundle exec rails db:migrate DATABASE=cable
RAILS_ENV=production bundle exec rails db:migrate DATABASE=queue
