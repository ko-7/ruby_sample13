FROM ruby:2.7.3

# 以下の記述を追加
ENV RAILS_ENV=production


RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && apt-get update && \
    apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev sudo vim

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn && apt-get install imagemagick


RUN yarn add node-sass

WORKDIR /app
RUN mkdir -p tmp/pids
RUN mkdir -p tmp/sockets
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
COPY yarn.lock /app
COPY package.json /app

# bundlerのバージョンを指定してbundle install
ENV BUNDLER_VERSION 2.2.17
RUN gem install bundler:$BUNDLER_VERSION
RUN bundle install

# ここでyarn installをしないとwebpackerを実行できない
RUN yarn install
COPY . /app

# RUN yarn add jquery popper.js bootstrap

# WARNING:webpack:installをするとwebpackの設定ファイルが初期化されてjqueryなどが使えなくなってしまう
# RUN rails webpacker:install
RUN NODE_ENV=production ./bin/webpack

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# 以下の記述があることでnginxから見ることができる
VOLUME /app/public
VOLUME /app/tmp

CMD bash -c "rm -f tmp/pids/server.pid && bundle exec puma -C config/puma.rb"