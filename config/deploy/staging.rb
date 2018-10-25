set :stage, :staging
set :branch, :master
set :deploy_to, -> { "/srv/www/#{fetch(:application)}" }
set :wpcli_remote_url, 'https://staging.example.com'

server 'staging.example.com', user: 'deploy', roles: %w{web app db}

fetch(:default_env).merge!(wp_env: :staging)
