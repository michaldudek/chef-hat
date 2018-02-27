# add PPA repository for 5.6
apt_repository "php5-5.6" do
    uri node["php"]["ppa"]["uri"]
    key node["php"]["ppa"]["key"]
    keyserver node["php"]["ppa"]["key_server"]
    components node["php"]["ppa"]["components"]
end

# install modules
node["php"]["modules"].each do |pkg|
    package pkg do
        action :install
    end
end

# configure
directory node["php"]["conf_dir"] do
  owner "root"
  group "root"
  mode "0644"
  recursive true
end

template node["php"]["conf_dir"] + "/php.ini" do
    source "php.ini.erb"
    owner "root"
    group "root"
    mode "0644"
    variables({
        :config => node["php"]["config"]
    })
end
