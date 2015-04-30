lock '3.3.5'

set :application, 'prelaunchr_default'
set :repo_url, 'https://github.com/brahmadpk/prelaunchr-default'
set :deploy_to, '/home/brahmadpk/webapps/prelaunchr_default'
set :default_env, { path: "/home/brahmadpk/webapps/prelaunch_default/bin:$PATH", gem_home: "/home/brahmadpk/webapps/prelaunch_default/gems" }

after "deploy:started", "figaro:setup"
after "deploy:updating", "figaro:symlink"
