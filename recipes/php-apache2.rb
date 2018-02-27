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
