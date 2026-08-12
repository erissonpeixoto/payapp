# Use the official Ruby image matching your .ruby-version
FROM ruby:4.0-slim

# Install essential dependencies. nodejs is required at runtime as the
# ExecJS/Uglifier JS engine (still used by the asset pipeline) -- planned
# for removal once the asset pipeline moves to Dart Sass + Terser.
RUN apt-get update -qq && apt-get install -y --no-install-recommends build-essential libpq-dev nodejs && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems (uses the Bundler bundled by default with this Ruby image)
RUN bundle install

# Copy the rest of the application code
COPY . .

# Copy the entrypoint script
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# The main command to run when the container starts
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
