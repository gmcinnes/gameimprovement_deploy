#
# Cookbook Name:: site-monit 
# Recipe:: init_fix 
#
# Copyright 2013, Gameimprovement 
#
# All rights reserved - Do Not Redistribute
#
# Fix a bug in the monit init.d script (see:
# https://bugs.launchpad.net/ubuntu/+source/monit/+bug/993381)
ruby_block "Fix monit init script bug" do
  block do
    init = Chef::Util::FileEdit.new("/etc/init.d/monit")
    init.search_file_replace_line(/if \[ "\$1" == "start" \]/, 'if [ "$1" = "start" ]')
    init.write_file
  end
end
