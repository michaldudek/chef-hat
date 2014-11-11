include_recipe "apache2"
include_recipe "focusson::php"

package "phpmyadmin" do 
    action :install
end

bash "phpmyadmin" do
    code <<-EOH
        sed -i 's,Alias /phpmyadmin /usr/share/phpmyadmin,Alias /pmadmin /usr/share/phpmyadmin,g' /etc/phpmyadmin/apache.conf
        sed -i '$ a\Include /etc/phpmyadmin/apache.conf' /etc/apache2/apache2.conf
        service apache2 restart 
    EOH
    action :run
end
