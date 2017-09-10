FROM ruby:2.0.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /CDB3
WORKDIR /CDB3
ADD Gemfile /CDB3/Gemfile
ADD Gemfile.lock /CDB3/Gemfile.lock
RUN bundle install
ADD . /CDB3