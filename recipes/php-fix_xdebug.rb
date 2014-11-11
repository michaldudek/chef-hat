bash "fix_xdebug" do
    code <<-EOH
        rm /etc/php5/conf.d/xdebug.ini
    EOH
    only_if do
        File.exists?("/etc/php5/conf.d/xdebug.ini")
    end
end