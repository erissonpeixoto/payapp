#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /usr/src/app/tmp/pids/server.pid

# Check if database exists by trying to connect. If not, create it.
# The `rails runner` command will exit with a non-zero status if it can't connect.
if ! bundle exec rails runner 'ActiveRecord::Base.connection' > /dev/null 2>&1; then
  bundle exec rake db:create
  echo "Database created."
fi

# Always run migrations.
echo "Running database migrations..."
bundle exec rake db:migrate

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
