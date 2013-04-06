ruby_block "Fix monit init script bug" do
  block do
    init = Chef::Util::FileEdit.new("/etc/init.d/monit")
    init.search_file_replace_line(/if \[ "\$1" == "start" \]/, 'if [ "$1" = "start" ]')
    init.write_file
  end
end
