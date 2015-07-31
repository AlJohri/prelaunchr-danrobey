thenosacrificediet-prelaunchr
=============================

http://thenosacrificediet.com

- This code was originally forked from https://github.com/harrystech/prelaunchr
- I have forked it from https://github.com/brahmadpk/prelaunchr-danrobey

## Setup
```
touch config/application.yml
bundle install
bundle exec rake db:create db:schema:load db:seed
bundle exec foreman start
```

## Deploy
```
bundle exec cap production deploy
```

----------------------------------------------------------------

## Pre-Setup (for Cent OS 6.6 with CPanel)
Root Access
```
# ssh in as root and run visudo. then add these two lines at the bottom
thenosacrificedi ALL=(ALL) ALL
thenosacrificedi ALL=NOPASSWD: ALL
```

Install Ruby
```
# instructions modified from: https://gist.github.com/jpfuentes2/2002954
sudo su - # or ssh as root
git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv

# Add rbenv to the path
echo '# rbenv setup - only add RBENV PATH variables if no single user install found' > /etc/profile.d/rbenv.sh
echo 'if [[ ! -d "${HOME}/.rbenv" ]]; then' >> /etc/profile.d/rbenv.sh
echo '  export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh
echo '  export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
echo '  eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
echo 'fi'  >> /etc/profile.d/rbenv.sh

chmod +x /etc/profile.d/rbenv.sh

mkdir -p ~/tmp
git clone git://github.com/sstephenson/ruby-build.git
cd ruby-build
./install.sh
rm -rf ~/tmp/ruby-build
TMPDIR=~/tmp rbenv install 1.9.3-p551
rbenv global 1.9.3-p551
export PATH=$PATH:/usr/local/bin # also add to .bash_profile
gem install bundler
gem install passenger
rbenv rehash
```

Install Passenger
```
sudo su - # or ssh as root
TMDIR=~/tmp passenger-install-apache2-module
# add LoadModule command to /usr/local/apache/conf/includes/pre_main_global.conf
# go into main config file and find the virtual host for this website
# uncomment the include file at the bottom and put the Passenger commands in there
```

Install Postgres
```
sudo su - # or ssh as root
/scripts/installpostgres # installs postgresql 8.4
```

Configure Postgres
```
sudo su - # or ssh as root
echo "host all all ::1/128 md5" >> /var/lib/pgsql/data/pg_hba.conf
su postgres # change to postgres user
pg_ctl -D /var/lib/pgsql/data/ reload
```

Install Node (Rails needs a Javascript Runtime)
```
sudo su - # or ssh as root
curl -sL https://rpm.nodesource.com/setup | bash -
yum install -y nodejs
```

Apache Commands
```
sudo su -
/usr/local/apache/bin/apachectl restart
/usr/local/apache/bin/apachectl -t -D DUMP_MODULES
sudo service httpd stop
sudo service httpd start
```

Helpful Links:
- https://www.phusionpassenger.com/documentation/Users%20guide%20Apache.html
- https://www.phusionpassenger.com/documentation/ServerOptimizationGuide.html
- http://robmclarty.com/blog/how-to-setup-a-production-server-for-rails-4
