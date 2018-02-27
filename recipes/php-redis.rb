git "/tmp/phpredis" do
    repository node["php"]["redis"]["repository"]
    revision node["php"]["redis"]["version"]
    action :sync
    not_if "php -m | grep redis"
end

bash "make & install phpredis" do
    cwd "/tmp/phpredis"
    code <<-EOF
        phpize
        ./configure
        make && make install
    EOF
    not_if "php -m | grep redis"
end

template node["php"]["ext_conf_dir"] + "/redis.ini" do
    source "redis.ini.erb"
    owner "root"
    group "root"
    mode "0644"
end

link node["php"]["real_conf_dir"] + "/20-redis.ini" do
    to node["php"]["ext_conf_dir"] + "/redis.ini"
    only_if do
        node["php"]["real_conf_dir"] != node["php"]["ext_conf_dir"]
    end
end
