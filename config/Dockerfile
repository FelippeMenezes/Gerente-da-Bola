# Dockerfile

# ---- Base Image ----
# Use the official Ruby image.
# https://hub.docker.com/_/ruby
FROM ruby:3.1.4-slim as base

# Install system dependencies required for Rails, Node, Yarn, and pg gem
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential \
    git \
    libpq-dev \
    libvips \
    pkg-config \
    nodejs \
    yarn

# Set working directory
WORKDIR /rails

# ---- Builder ----
# Install gems
FROM base as builder

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install --jobs 4 --retry 3 && \
    rm -rf vendor/bundle/ruby/*/cache

# Copy the rest of the application code
COPY . .

# ---- Assets Precompilation ----
# Precompile assets in a separate step to keep the final image clean.
# This is where the build fails with buildpacks.
# We set a dummy secret key base so assets:precompile can run.
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

# ---- Final Image ----
# Create the final, smaller image for production
FROM base as final

# Copy gems and application code from the builder stage
COPY --from=builder /rails /rails
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/

# Expose port 3000 to the outside world
EXPOSE 3000

# Set the entrypoint to run the Rails server
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start the server by default
CMD ["bundle", "exec", "rails", "server"]