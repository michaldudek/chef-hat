include_recipe "chef-hat::base"
include_recipe "chef-hat::php"

execute "composer install" do
    command "curl -s http://getcomposer.org/installer | php && mv composer.phar /usr/bin/composer"
    creates "/usr/bin/composer"
    action :run
end

execute "composer update" do
    command "composer self-update"
    action :run
end
