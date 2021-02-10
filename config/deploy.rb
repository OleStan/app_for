lock "~> 3.15.0"

set :repo_url, "git@github.com:OleStan/app_for.git"
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :user, "deployer"
set :rvm_ruby_version, "2.7.2"
set :pty, true

set :linked_files, fetch(:linked_files, []).push("config/database.yml", "config/secrets.yml", "config/master.key", "config/puma.rb")
set :linked_dirs,  fetch(:linked_dirs, []).push("log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads", "public/images", "storage")

set :config_example_suffix, ".example"
set :config_files, ["config/database.yml", "config/secrets.yml"]
set :nginx_use_ssl, false

namespace :deploy do
  before 'check:linked_files', 'set:master_key'
  before 'check:linked_files', 'config:push'
  before 'check:linked_files', 'puma:jungle:setup'
  before 'check:linked_files', 'puma:nginx_config'
  
end


after "deploy:finished", "nginx:restart"
after "deploy:finished", "puma:start"

before "deploy:assets:precompile", "deploy:yarn_install"

namespace :deploy do
  desc 'Run rake yarn:install'
  task :yarn_install do
    on roles(:web) do
      within release_path do
        execute("cd #{release_path} && yarn install")
      end
    end
  end
end