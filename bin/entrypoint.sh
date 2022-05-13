#!/bin/bash

bundle exec sequel -m migrations $DB_URL
bundle exec ruby app.rb -o 0.0.0.0
