Vagrant.configure("2") do |config|
    # install ubuntu
    config.vm.box = "bento/ubuntu-16.04"

    # configure network
    config.vm.hostname = "chefhat.dev"
    config.vm.network "private_network", ip: "192.168.255.16", network: "255.255.0.0"

    # VirtualBox specific config - eg. composer memory problem
    config.vm.provider :virtualbox do |vb, override|
        override.vm.synced_folder ".", "/vagrant", :nfs => true
        override.vm.synced_folder "./tests/fixtures", "/var/www/chefhat", :nfs => true
        vb.customize ["modifyvm", :id, "--rtcuseutc", "on"]
        vb.customize ["modifyvm", :id, "--memory", 1024]
        vb.customize ["modifyvm", :id, "--cpus", 1]
    end

    # manage hosts file on the host machine
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true
    config.hostmanager.aliases = [
        "www.chefhat.dev",
        "test.chefhat.dev",
        "www.test.chefhat.dev",
        "info.chefhat.dev",
        "www.info.chefhat.dev",
        "secure.chefhat.dev",
        "www.secure.chefhat.dev"
    ]

    # fixed chef version to be sure that recipes are working
    config.omnibus.chef_version = :latest

    # chef recipes
    config.berkshelf.enabled = true
    config.berkshelf.berksfile_path = "./Berksfile"

    config.vm.provision "chef_solo" do |chef|
        chef.run_list = [
            "recipe[apt]",
            "recipe[apache2]",
            "recipe[chef-hat::base]",
            "recipe[chef-hat::php]",
            "recipe[chef-hat::php-apache2]",
            "recipe[chef-hat::php-composer]",
            "recipe[chef-hat::php-xdebug]",
            "recipe[chef-hat::vhosts]"
        ]
        chef.json = {
            "apache" => {
                # apache should run as vagrant:vagrant in Vagrant with NFS synced dirs, due to dir permissions
                "user" => "vagrant",
                "group" => "vagrant"
            },
            "vhosts" => {
                "100-chefhat" => {
                    "host" => "chefhat.dev",
                    "root_dir" => "/var/www/chefhat",
                    "log_dir" => "logs",
                    "doc_root" => ""
                },
                "101-chefhat-test" => {
                    "host" => "test.chefhat.dev",
                    "root_dir" => "/var/www/chefhat",
                    "log_dir" => "logs",
                    "doc_root" => "",
                    "force_www" => "yes"
                },
                "102-chefhat-info" => {
                    "host" => "info.chefhat.dev",
                    "root_dir" => "/var/www/chefhat",
                    "log_dir" => "logs",
                    "doc_root" => "",
                    "force_www" => "no_www"
                },
                "103-chefhat-secure" => {
                    "host" => "www.secure.chefhat.dev",
                    "root_dir" => "/var/www/chefhat",
                    "log_dir" => "logs",
                    "doc_root" => "",
                    "force_www" => "yes",
                    "ssl" => {
                        "enabled" => true
                    }
                }
            }
        }
    end

    # also run hostmanager after all provisioning has happened
    config.vm.provision :hostmanager

end
