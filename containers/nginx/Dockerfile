# v1---------------------------------------------------------------
# FROM nginx:1.15.8

# # インクルード用のディレクトリ内を削除
# RUN rm -f /etc/nginx/conf.d/*

# # Nginxの設定ファイルをコンテナにコピー
# ADD nginx.conf /etc/nginx/conf.d/webapp.conf

# # ビルド完了後にNginxを起動
# CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf

# v2-------------------------------------------------------------------
FROM nginx:1.16
RUN apt-get update && \
    apt-get install -y apt-utils \
    locales && \
    echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8

# 初期状態の設定ファイル
ADD ./containers/nginx/nginx.conf /etc/nginx/nginx.conf
# ADD ./containers/nginx/default.conf /etc/nginx/conf.d/default.conf