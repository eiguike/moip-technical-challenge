FROM postgres
FROM ruby:2.4.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /moip-technical-challenge
WORKDIR /moip-technical-challenge
COPY Gemfile /moip-technical-challenge/Gemfile
COPY Gemfile.lock /moip-technical-challenge/Gemfile.lock
RUN bundle install
COPY . /moip-technical-challenge
