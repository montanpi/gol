FROM ruby:3.2.0-alpine
RUN apk add --no-cache build-base tzdata
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
RUN rails assets:precompile
RUN rails db:drop db:create db:migrate db:seed
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
 