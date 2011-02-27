namespace :spree_authorize_net_reports do
  desc "Copies all migrations and assets (NOTE: This will be obsolete with Rails 3.1)"
  task :install do
    Rake::Task['spree_authorize_net_reports:install:migrations'].invoke
    Rake::Task['spree_authorize_net_reports:install:assets'].invoke
    Rake::Task['spree_authorize_net_reports:install:authorize_net'].invoke
  end

  namespace :install do
    desc "Copies all migrations (NOTE: This will be obsolete with Rails 3.1)"
    task :migrations do
      source = File.join(File.dirname(__FILE__), '..', '..', 'db')
      destination = File.join(Rails.root, 'db')
      Spree::FileUtilz.mirror_files(source, destination)
    end

    desc "Copies all assets (NOTE: This will be obsolete with Rails 3.1)"
    task :assets do
      source = File.join(File.dirname(__FILE__), '..', '..', 'public')
      destination = File.join(Rails.root, 'public')
      puts "INFO: Mirroring assets from #{source} to #{destination}"
      Spree::FileUtilz.mirror_files(source, destination)
    end

    desc "Copy authorize-net-1.5.2 to vendor"
    task :authorize_net do
      source = File.join(File.dirname(__FILE__), '..', '..', 'vendor', 'plugins')
      destination = File.join(Rails.root, 'vendor', 'plugins')
      Spree::FileUtilz.mirror_files(source, destination)
    end
  end

end