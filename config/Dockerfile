# ---- STAGE 1: Base Image ----
# Use the official slim Ruby image. It's smaller.
FROM ruby:3.1.4-slim AS base

# Set environment variables
ENV RAILS_ENV=production \
    APP_HOME=/rails

# Set the working directory
WORKDIR $APP_HOME

# Install essential system dependencies
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential \
    git \
    libpq-dev \
    nodejs \
    yarn


# ---- STAGE 2: Gem Builder ----
# Install gems in a separate layer to leverage Docker cache
FROM base AS gem_builder

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install --jobs $(nproc) --retry 3


# ---- STAGE 3: Application Builder ----
# Copy the application code and precompile assets
FROM base AS app_builder

# Copy installed gems from the previous stage
COPY --from=gem_builder $APP_HOME $APP_HOME
COPY --from=gem_builder /usr/local/bundle/ /usr/local/bundle/

# Copy the rest of the application code
COPY . .

# Precompile assets. This requires a dummy secret key.
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile


# ---- STAGE 4: Final Production Image ----
# This is the stage we will actually run. It's named "final".
FROM base AS final

# Copy gems and precompiled assets from the builder stages
COPY --from=gem_builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=app_builder $APP_HOME $APP_HOME

# Expose port 3000 to the Koyeb network
EXPOSE 3000

# Set the entrypoint to our custom script to handle server.pid
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# The default command to run when the container starts
CMD ["bundle", "exec", "rails", "server"]