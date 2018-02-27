# ext-mongo requires some additional packages to build
packages_list = %w(
    php-pear
    libcurl4-openssl-dev
    pkg-config
    libssl-dev
    libsslcommon2-dev
)

packages_list.each do |name| 
    package name do 
        action :install
    end
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
