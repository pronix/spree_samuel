require 'capistrano/ext/multistage'
set :application, "spree_samuel"
set :default_stage, "staging"
set :repository,  "git@github.com:pronix/spree_samuel.git"
set :scm, :git
