FROM ruby:3.0.0-alpine

RUN apk --update add build-base nodejs tzdata postgresql-dev postgresql-client libxslt-dev libxml2-dev imagemagick

ENV INSTALL_PATH /app
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

ENV RAILS_ENV production
ENV RACK_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

COPY Gemfile Gemfile.lock ./

RUN gem install bundler
RUN bundle config set --local without 'development test'
RUN bundle install
RUN bundle exec rails assets:precompile

COPY . .

EXPOSE 3000

CMD ['rails', 'server', '-b', '0.0.0.0']
