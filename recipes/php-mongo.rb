bash "php-mongo" do
    code <<-EOH
        pecl install --soft mongo
    EOH
    action :run
    not_if "pecl info mongo | grep version"
end

template "/etc/php5/conf.d/mongo.ini" do
    source "mongo.ini.erb"
    owner "root"
    group "root"
    mode "0644"
    not_if do
        File.exists?("/etc/php5/conf.d/mongo.ini")
    end
end

file '/etc/php5/conf.d/mongo.ini' do
    mode "0644"
end