# require apache2 with mod_php5 to be already installed
include_recipe "chef-hat::php"
include_recipe "apache2"

package "libapache2-mod-php7.0"

directory "/etc/php/7.0/apache2" do
    action :delete
    recursive true
end

link "/etc/php/7.0/apache2" do
    to node["php"]["conf_dir"]
    notifies :reload, "service[apache2]"
end
