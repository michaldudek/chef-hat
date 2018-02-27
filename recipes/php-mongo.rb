# ext-mongo requires pecl which requires pear
package "php-pear" do
    action :install
end

bash "install php ext-mongo" do
    code <<-EOH
        pecl install --soft mongo
    EOH
    action :run
    not_if "pecl info mongo | grep version"
end

template node["php"]["ext_conf_dir"] + "/mongo.ini" do
    source "mongo.ini.erb"
    owner "root"
    group "root"
    mode "0644"
end

link node["php"]["real_conf_dir"] + "/20-mongo.ini" do
    to node["php"]["ext_conf_dir"] + "/mongo.ini"
    only_if do
        node["php"]["real_conf_dir"] != node["php"]["ext_conf_dir"]
    end
end
