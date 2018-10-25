set :stage, :production
set :branch, :stable
set :deploy_to, -> { "/srv/www/#{fetch(:application)}" }
set :wpcli_remote_url, 'https://example.com'

server 'example.com', user: 'deploy', roles: %w{web app db}

fetch(:default_env).merge!(wp_env: :production)
