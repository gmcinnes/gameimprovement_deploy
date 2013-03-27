execute "apt-get upgrade" do
  command "apt-get upgrade -y --force-yes"
  ignore_failure true
end
