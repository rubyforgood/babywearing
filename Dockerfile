FROM ruby:2.6.5

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
 nodejs

COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app
RUN bundle install

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
