github_repository = ''

raise 'You have to fill github_repository variable' if github_repository.empty?

# do not modify below

# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'WIS-client'
set :repo_url, github_repository
set :branch, 'master'
set :deploy_to, '/var/www/wis-client'
set :puma_bind, "tcp://0.0.0.0:3000"
set :puma_state, "#{shared_path}/puma.state"
set :puma_pid, "#{shared_path}/puma.pid"
set :puma_access_log, "#{shared_path}/puma_access.log"
set :puma_error_log, "#{shared_path}/puma_error.log"
