bash "fix_apc" do
    code <<-EOH
        rm /etc/php5/conf.d/apc.ini
    EOH
    only_if do
        File.exists?("/etc/php5/conf.d/apc.ini")
    end
end
