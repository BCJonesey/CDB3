FROM ruby:2.2.7
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs postgresql \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN apt-get install -y \
        curl \
        libxrender1 \
        libfontconfig \
        xz-utils

RUN gem install foreman
RUN mkdir /CDB3
WORKDIR /CDB3
ADD Gemfile /CDB3/Gemfile
ADD Gemfile.lock /CDB3/Gemfile.lock
RUN bundle install
ADD . /CDB3