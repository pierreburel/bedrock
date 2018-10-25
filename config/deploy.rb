set :application, 'my_app_name'
set :repo_url, 'git@example.com:me/my_repo.git'

set :theme_name, 'my_theme'
set :theme_build, 'npm install && npm run build --production'
set :theme_assets, 'assets'

set :wpcli_local_url, ENV['WP_HOME']
set :wpcli_backup_db, true
set :wpcli_local_db_backup_dir, 'backup'

set :linked_files, fetch(:linked_files, []).push('.env', 'web/.htaccess')
set :linked_dirs, fetch(:linked_dirs, []).push('web/app/uploads')

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :service, :nginx, :reload
    end
  end
end

namespace :assets do
  set :theme_path, Pathname.new('web/app/themes').join(fetch(:theme_name))
  set :local_theme_path, Pathname.new(File.dirname(__FILE__)).join('../').join(fetch(:theme_path))

  desc 'Compile theme assets'
  task :compile do
    run_locally do
      execute "cd #{fetch(:local_theme_path)}; #{fetch(:theme_build)}"
    end
  end

  desc 'Upload theme assets'
  task :upload do
    on roles(:web) do
      set :remote_assets_path, release_path.join(fetch(:theme_path)).join(fetch(:theme_assets))
      execute :mkdir, '-p', fetch(:remote_assets_path)
      upload! fetch(:local_theme_path).join(fetch(:theme_assets)).to_s, fetch(:remote_assets_path), recursive: true
    end
  end

  desc 'Compile and upload theme assets'
  task deploy: %w(compile upload)
end

# The above assets:deploy task is not run by default
# Uncomment the following line to run it on deploys
# before 'deploy:updated', 'assets:deploy'
