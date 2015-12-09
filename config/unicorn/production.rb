application = 'reserve-hacker'

worker_processes 2 #EC2のインスタンスのCPU数より少し大きく
app_path = "/var/www/baukis"
#標準だとsharedに作成される
#ここが一番重要
#Nginxのupstreamで設定した「server unix:/var/www/あなたのアプリ名/shared/tmp/sockets/unicorn.sock」の場所と合わせる！！
listen "#{app_path}/shared/tmp/sockets/unicorn.sock"
pid "#{app_path}/current/tmp/unicorn.pid"

#何秒でタイムアウトするか
timeout 60

#ダウンタムをなくす
preload_app true

stdout_path "#{app_path}/current/log/production.log"# 標準出力ログ出力先
stderr_path "#{app_path}/current/log/production.log"# 標準エラー出力ログ出力先

GC.respond_to?(:copy_on_write_friendly=) and GC.copy_on_write_friendly = true


