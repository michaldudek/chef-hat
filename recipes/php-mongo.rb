# ext-mongo requires pecl which requires pear
package "php-pear" do
    action :install
end

bash "install php ext-mongodb" do
    code <<-EOH
        pecl install --soft mongodb
    EOH
    action :run
    not_if "pecl info mongodb | grep version"
end

template node["php"]["ext_conf_dir"] + "/mongodb.ini" do
    source "mongodb.ini.erb"
    owner "root"
    group "root"
    mode "0644"
end

link node["php"]["real_conf_dir"] + "/20-mongodb.ini" do
    to node["php"]["ext_conf_dir"] + "/mongodb.ini"
    only_if do
        node["php"]["real_conf_dir"] != node["php"]["ext_conf_dir"]
    end
end
