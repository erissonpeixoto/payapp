# Use the official Ruby image matching your .ruby-version
FROM ruby:4.0-slim

# Default to production -- Nixpacks' Rails provider used to set this
# automatically at build time, but a plain Dockerfile doesn't, and Rails
# silently boots as "development" without it (wrong config.hosts allowlist,
# verbose error pages, config.assets.compile fallback, etc). docker-compose.yml
# overrides this back to "development" for local dev, and any RAILS_ENV set
# on the hosting platform overrides it too -- this is only the fallback.
ENV RAILS_ENV=production

# Install essential dependencies.
RUN apt-get update -qq && apt-get install -y --no-install-recommends build-essential libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems (uses the Bundler bundled by default with this Ruby image)
RUN bundle install

# Copy the rest of the application code
COPY . .

# Precompile assets (Tailwind CSS + the Sprockets/importmap manifest used to
# serve images and pinned JS) so they don't depend on compiling on the fly --
# config.assets.compile is false in production. SECRET_KEY_BASE_DUMMY lets
# this run at build time, before the real secret is available as a runtime
# env var.
RUN SECRET_KEY_BASE_DUMMY=1 RAILS_ENV=production bin/rails assets:precompile

# Copy the entrypoint script
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# The main command to run when the container starts
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
