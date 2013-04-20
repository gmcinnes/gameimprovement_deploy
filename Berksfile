site :opscode

cookbook 'apt'
cookbook 'unattended_upgrades'
cookbook 'bootstrap', path: "./site-cookbooks/bootstrap"
cookbook 'site_monit', path: "./site-cookbooks/site_monit"
cookbook 'backupninja', path: "./site-cookbooks/backupninja"
cookbook 'rbenv'
cookbook 'monit'
cookbook 'ntp'
cookbook 'build-essential'
cookbook 'vim'
# Pulling this from git because community cookbook doesn't work
# with Chef 11 yet
cookbook 'ufw', git: 'https://github.com/opscode-cookbooks/ufw.git'
cookbook 'openssh'
cookbook 'sudo'
cookbook 'postfix'
cookbook 'nginx'
cookbook 'nodejs'
cookbook 'unicorn'
# Pulling this from a simpler mongodb chef implementation, because
# the community cookbook one seems to fail in a myriad of ways 
cookbook 'mongodb', git: 'https://github.com/sdomino/chef-mongodb.git'
cookbook 'logrotate'
cookbook 'phantomjs'
cookbook 'fail2ban'
cookbook 'user'

