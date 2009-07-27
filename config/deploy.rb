set :application, "budgeto"
set :repository,  "git@github.com:bradx3/fundation.git"
set :deploy_to, "/var/www/#{application}"
set :scm, :git
set :use_sudo, false

host = "budgeto.lucky-dip.net"
role :app, host
role :web, host
role :db, host, :primary => true

namespace :deploy do

  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end

end
