# ステージ間で共通の設定
# 設定値はsetで設定し、fetchで取り出し
# 個々のタスクはtask タスク名; do ... endのブロックで定義
# taskブロックの中には, run-locally do; ... end もしくは、 on 対象サーバ do; ... end を書く

# config valid only for Capistrano 3.1
#lock '3.2.1'

set :application, 'my_app_name'
set :repo_url, 'https://github.com/shshimamo/baukis-on-rails-4-2.git'

set :branch, 'master' #マージ前なら他のブランチでも設定可能
set :deploy_to, '/var/www/baukis'
set :keep_releases, 5 #何個アプリを確保しておくか。この場合はデプロイした最新のアプリ5個をキープ
set :rbenv_type, :user
set :rbenv_ruby, '2.1.5'     #rubyのバージョン間違えないように!
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all
set :linked_dirs, %w{bin log tmp/backup tmp/pids tmp/cache tmp/sockets vendor/bundle}

set :rbenv_custom_path, '/home/cap/.rbenv'

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end

#namespace :deploy do
#  desc 'Restart application'
#  task :restart do
#    on roles(:app), in: :sequence, wait: 5 do
#      # Your restart mechanism here, for example:
#      # execute :touch, release_path.join('tmp/restart.txt')
#    end
#  end
#
#  after :publishing, :restart
#
#  after :restart, :clear_cache do
#    on roles(:web), in: :groups, limit: 3, wait: 10 do
#      # Here we can do anything such as:
#      # within release_path do
#      #   execute :rake, 'cache:clear'
#      # end
#    end
#  end
#end
