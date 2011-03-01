# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
#
set :deploy_via, :copy
set :deploy_to, "~/#{application}"
set :use_sudo, false

set :user, "novawhite"

role :web, "178.79.155.245"                          # Your HTTP server, Apache/etc
role :app, "178.79.155.245"                          # This may be the same as your `Web` server
role :db,  "178.79.155.245", :primary => true # This is where Rails migrations will run
set :ssh_options, {:forward_agent => true}

set :rails_env, "production"
set :keep_releases, 3

after "deploy:update","deploy:bootstrap"
before "deploy:bootstrap","bundle:install"
#before "spree:install", "bundle:install"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :bootstrap, :roles => :db do
    run "cd #{current_path} && RAILS_ENV=production bundle exec rake db:migrate --trace"
    run "cd #{current_path} && RAILS_ENV=production bundle exec rake db:sample AUTO_ACCEPT=true"
  end
end

namespace :bundle do
  task :install do
      run "cd #{current_path}; bundle install --deployment;"
      #run "ln -nfs #{shared_path}/cached-copy/vendor/bundle  #{latest_release}/vendor/bundle"
  end
end

