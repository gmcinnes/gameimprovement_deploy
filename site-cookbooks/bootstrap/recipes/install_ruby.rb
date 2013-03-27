
rbenv_ruby "1.9.3-p392" do
  global true
end

rbenv_gem "bundler" do
  ruby_version "1.9.3-p392"
end


ruby_block "insert_rbenv_stuff" do
  block do
    file = Chef::Util::FileEdit.new("/etc/skel/.profile")
    file.insert_line_if_no_match(/rbenv\/bin/, 'export PATH="$HOME/.rbenv/bin:$PATH"')
    file.write_file
    
    file = Chef::Util::FileEdit.new("/etc/skel/.profile")
    file.insert_line_if_no_match(/init/, 'eval "$(rbenv init -)"')
    file.write_file

  end
end
