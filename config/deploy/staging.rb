# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
#
set :deploy_via, :remote_cache
set :deploy_to, "/var/www/#{application}"
set :use_sudo, false

set :user, "root"

role :web, "178.79.132.92:6022"                          # Your HTTP server, Apache/etc
role :app, "178.79.132.92:6022"                          # This may be the same as your `Web` server
role :db,  "178.79.132.92:6022", :primary => true # This is where Rails migrations will run
set :ssh_options, {:forward_agent => true}

set :rails_env, "production"

after "deploy:update","deploy:migrate"
before "deploy:migrate", "symlink:db"
before "symlink:db","bundle:install"

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
  end
end

namespace :bundle do
  task :install do
      run "cd #{shared_path}/cached-copy; bundle install"# --deployment;"
      #run "ln -nfs #{shared_path}/cached-copy/vendor/bundle  #{latest_release}/vendor/bundle"
  end
end

namespace :symlink do
  desc "Symlink the database"
  task :db do
    run "ln -nfs #{shared_path}/database.yml #{release_path}/config/database.yml"
    #run "ln -nfs #{shared_path}/cached-copy/db/schema.rb #{release_path}/db/schema.rb"
  end
end

