require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'  # for rbenv support. (https://rbenv.org)

set :application_name, 'sparky'
set :domain, 'rediron.ru'
set :deploy_to, '/home/foxweb/www/sparky.rediron.ru'
set :repository, 'git@github.com:foxweb/sparky.git'
set :branch, 'master'

# Shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# Some plugins already add folders to shared_dirs like `mina/rails` add `public/assets`, `vendor/bundle` and many more
# run `mina -d` to see all folders and files already included in `shared_dirs` and `shared_files`
# set :shared_dirs, fetch(:shared_dirs, []).push('public/assets')
# set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml')

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :remote_environment do
  invoke :'rbenv:load'
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  command %{rbenv install 2.6.5 --skip-existing}
  command %{gem install bundler}
  # invoke :'rails:db_create'
end

desc "Deploys the current version to the server."
task :deploy do
  invoke :'git:ensure_pushed'

  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        command %{mkdir -p tmp/}
        command %{touch tmp/restart.txt}
      end
    end
  end
end
