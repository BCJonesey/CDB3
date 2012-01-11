#!/usr/bin/env rake # -*- ruby -*-
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Cdb3::Application.load_tasks

namespace :db do
  task :nuke do
    system("rake db:drop")
    system("rake db:create")
    system("rake db:migrate")
    system("rake db:fixtures:load")
  end
end
