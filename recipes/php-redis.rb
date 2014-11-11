# dependencies
include_recipe "git"

directory "/tmp/phpredis" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

git "/tmp/phpredis" do
  repository "git://github.com/nicolasff/phpredis.git"
  revision "master"
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

template "/etc/php5/mods-available/redis.ini" do
  source "redis.ini.erb"
  owner "root"
  group "root"
  mode "0644"
end

link '/etc/php5/conf.d/redis.ini' do
  to '/etc/php5/mods-available/redis.ini'
  owner "root"
  group "root"
  mode "0644"
  not_if do
    File.exists?("/etc/php5/conf.d/redis.ini")
  end
end

file '/etc/php5/conf.d/redis.ini' do
  mode "0644"
end