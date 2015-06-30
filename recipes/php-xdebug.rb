package "php5-xdebug" do
    action :install
end

template node["php"]["ext_conf_dir"] + "/xdebug.ini" do
    source "xdebug.ini.erb"
    owner "root"
    group "root"
    mode "0644"
    variables({
        :config => node["php"]["xdebug"]
    })
end

link node["php"]["real_conf_dir"] + "/10-xdebug.ini" do
    to node["php"]["ext_conf_dir"] + "/xdebug.ini"
    only_if node["php"]["real_conf_dir"] != node["php"]["ext_conf_dir"]
end
