lock '3.3.5'

set :rbenv_type, :system
set :rbenv_ruby, '2.2.2'

set :pty, true

set :application, 'prelaunchr'

set :repo_url, 'https://github.com/AlJohri/thenosacrificediet-prelaunchr'

set :deploy_to, '/home/thenosacrificedi/rails_apps/prelaunchr'

set :default_env, { path: "/usr/local/rbenv/shims:$PATH"}
# /home/thenosacrificedi/rails_apps/prelaunchr/bin
# gem_home: "/usr/local/rbenv/versions/2.2.2/lib/ruby/gems/2.2.0"

set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

after "deploy:started", "figaro:setup"
after "deploy:updating", "figaro:symlink"
