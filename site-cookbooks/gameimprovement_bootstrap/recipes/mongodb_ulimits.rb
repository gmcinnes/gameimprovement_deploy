resources("template[/etc/default/mongodb]").cookbook "gameimprovement_bootstrap"

ruby_block "edit /etc/init.d/mongodb to use bash" do
 block do
    rc = Chef::Util::FileEdit.new("/etc/init.d/mongodb")
    rc.search_file_replace_line(/^#!\/bin\/sh$/,
       "#!/bin/bash")
    rc.write_file
  end
end
