# Baukis - 顧客管理システム

## 説明

Baukis は企業向けの顧客管理システム（Ruby on Rails 学習用サンプル）です。

## システム要件

* CentOS 6.5 または Ubuntu 14.04
* Ruby 2.2.3
* MySQL 5.6 または PostgreSQL 9.3

## 準備作業

* PostgreSQL を使用する場合は、Gemfile の `mysql2` を `pg` で置き換えてください。

## 注意事項

* 以下の手順では、一般ユーザーの権限でコマンドを実行してください。

## インストール手順

* `gem install bundle` コマンドで Bundler をインストールしてください。
* この `README.rdoc` が存在するディレクトリで `bundle` コマンドを実行してください。

## データベースのセットアップ

* このシステム専用のデータベースを MySQL または PostgreSQL 上に作成してください。
* データベースへの接続パラメータに基づいて `config/database.yml` を作成してください。
  `config/skel` ディレクトリに作成例があります。
* `bin/rake db:setup` コマンドを実行してください。

## hosts ファイルの設定

* 開発マシンの `hosts` ファイルに次の 1 行を追加してください（要 root 権限）。
  `hosts` ファイルは、Mac OS X の場合は `/private/etc/hosts` フォルダに、
  Windows の場合は `C:\Windows\system32\drivers` フォルダにあります。

      127.0.0.1 example.com baukis.example.com

## システムの起動と終了

* `bin/rails s` コマンドを実行するとシステムが起動します。
* Ctrl-C を入力するとシステムが終了します。

## システムの利用

* ブラウザで以下の URL にアクセスしてください:
  * http://baukis.example.com:3000 -- 職員向けサイト
  * http://baukis.example.com:3000/admin -- 管理者向けサイト
  * http://example.com:3000/mypage -- 顧客向けサイト
