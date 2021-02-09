server "138.68.81.123", user: "#{fetch(:user)}", roles: %w{app db web}, primary: true

set :application, "app_for"
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"

set :environment, "production"
set :rails_env,   "production"

set :nginx_server_name, "138.68.81.123"
set :puma_conf, "#{shared_path}/config/puma.rb"