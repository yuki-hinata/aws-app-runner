# ベースイメージの指定
FROM php:8.3-cli

# 作業ディレクトリの設定
WORKDIR /var/www/html

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    && docker-php-ext-install zip pdo pdo_mysql

# Composerのインストール
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# アプリケーションのコピー
COPY . .

# 依存関係のインストール
RUN composer install

# ポートのエクスポート
EXPOSE 8080

# Laravelのサーバーを起動
CMD php -S 0.0.0.0:8080 -t public
