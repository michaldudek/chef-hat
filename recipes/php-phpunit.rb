directory "/tmp/phpunit" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

bash "phpunit" do
    cwd "/tmp/phpunit"
    code <<-EOH
        wget https://phar.phpunit.de/phpunit.phar
        chmod +x phpunit.phar
        mv phpunit.phar /usr/local/bin/phpunit
    EOH
end
