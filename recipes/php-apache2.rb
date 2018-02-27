# require apache2 with mod_php to be already installed
include_recipe "chef-hat::php"
include_recipe "apache2"
include_recipe "apache2::mod_php"

apache_module "php" do
    enable false
end

apache_module "php5.6" do
    enable true
end

directory "/etc/php5/apache2" do
    action :delete
    recursive true
end

link "/etc/php5/apache2" do
    to node["php"]["conf_dir"]
    notifies :reload, "service[apache2]"
end
