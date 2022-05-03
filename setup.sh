#!/bin/bash
bundle install
rails webpacker:install
rails assets:clobber
rails webpacker:compile
git reset --hard origin/main
rake db:migrate
rake db:seed
