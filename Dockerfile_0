FROM ruby:2.7.3

# 本番環境に設定する
ENV RAILS_ENV=production

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev sudo vim

# Nodeのインストール　※バージョンは任意で変更する！
RUN apt-get install -y nodejs npm && npm install n -g && n 14.16.0

# yarnのインストール
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
      echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
      apt-get update && apt-get install -y yarn

RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock

# gem(Rails6)のインストール
RUN bundle install
RUN yarn install --check-files
RUN bundle exec rails webpacker:compile

ADD . /myapp

# 以下の記述があることでnginxから見ることができる
VOLUME /app/public
VOLUME /app/tmp

