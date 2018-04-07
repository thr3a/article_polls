# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'article_polls'
set :repo_url, 'https://github.com/thr3a/article_polls.git'

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/article_polls'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')

# Default value for default_env is {}
set :default_env, {
  rails_master_key: `cat config/master.key`
}

set :rbenv_type, :system
set :rbenv_ruby, '2.3.4'
set :puma_threads,    [4, 16]
set :puma_workers,    1
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{shared_path}/log/puma.error.log"
set :puma_error_log,  "#{shared_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  after :publishing, :restart

  task :mkdir do
    on roles(:app), in: :sequence, wait: 5 do
      execute :sudo, :mkdir, '-p', "#{fetch(:deploy_to)}"
      execute :sudo, :chown, "#{fetch(:user)}:#{fetch(:user)}", "#{fetch(:deploy_to)}"
    end
  end

  task :upload do
    on roles(:app), in: :sequence, wait: 5 do
      fetch(:linked_files).each do |filename|
        execute :mkdir, '-p', "#{File.dirname(filename)}"
        upload!(filename, "#{shared_path}/#{filename}")
      end
    end
  end
  
end
