lock '3.3.5'

set :application, 'prelaunchr'

set :repo_url, 'https://github.com/brahmadpk/prelaunchr-danrobey'

set :deploy_to, '/home/danrobey/webapps/prelaunchr'

set :default_env, { path: "/home/danrobey/webapps/prelaunchr/bin:$PATH", gem_home: "/home/danrobey/webapps/prelaunchr/gems" }

set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

after "deploy:started", "figaro:setup"
after "deploy:updating", "figaro:symlink"
