FROM ruby:3.2.0-alpine
RUN apk add --no-cache build-base tzdata
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
RUN rails assets:precompile
RUN rails db:drop db:create
RUN rails db:migrate RAILS_ENV=development
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
 