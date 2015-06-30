include_recipe "apt"

# add PPA repository for 5.6
apt_repository "php5-5.6" do
    uri node["php"]["ppa"]["uri"]
    key node["php"]["ppa"]["key"]
    keyserver node["php"]["ppa"]["key_server"]
    #components ['trusty', 'main']
end

# install modules
node["php"]["modules"].each do |pkg|
    package pkg do
        action :install
    end
end
