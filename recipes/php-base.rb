packages_list = %w(
    php5-memcache
    php5-memcached
    php-pear
    php5-dev
)

packages_list.each do |name| 
    package name do 
        action :install
    end
end
