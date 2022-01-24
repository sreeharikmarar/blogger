FROM ruby:2.6.8
RUN apt-get update -qq &&\
  apt-get install -y build-essential libpq-dev &&\
  gem install bundler
WORKDIR /app
ENV RAILS_ENV=production

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
COPY config/application.yml.sample config/application.yml
RUN bundle install
COPY . /app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
