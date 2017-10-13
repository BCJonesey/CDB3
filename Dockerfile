FROM ruby:2.2.7

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list


RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn postgresql \
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
RUN yarn install
