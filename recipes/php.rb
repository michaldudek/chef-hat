# add PPA repository for 5.6
apt_repository "php-7.0" do
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
template node["php"]["conf_dir"] + "/php.ini" do
    source "php.ini.erb"
    owner "root"
    group "root"
    mode "0644"
    variables({
        :config => node["php"]["config"]
    })
end
