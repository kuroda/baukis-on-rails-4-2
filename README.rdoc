= Baukis - 顧客管理システム

== 説明

Baukis は企業向けの顧客管理システム（Ruby on Rails 学習用サンプル）です。

== システム要件

* CentOS 6.5 または Ubuntu 14.04
* Ruby 2.1.1
* MySQL 5.6 または PostgreSQL 9.3

== 準備作業

- PostgreSQL を使用する場合は、Gemfile の 'mysql2' を 'pg' で置き換えてください。

== 注意事項

- 以下の手順では、一般ユーザーの権限でコマンドを実行してください。

== インストール手順

- gem コマンドで bundler をインストールしてください。
- この README.rdoc が存在するディレクトリで bundle コマンドを実行してください。

== データベースのセットアップ

- このシステム専用のデータベースを MySQL または PostgreSQL 上に作成してください。
- データベースへの接続パラメータに基づいて config/database.yml を修正してください。
- RAILS_ENV=production bin/rake db:setup コマンドを実行してください。

== システムの起動と終了

- bin/rails s -e production コマンドを実行するとシステムが起動します。
- Ctrl-C を入力するとシステムが終了します。
