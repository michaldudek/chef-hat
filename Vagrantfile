Vagrant.configure("2") do |config|
    # install ubuntu
    config.vm.box = "chef/ubuntu-14.04"

    # configure network
    config.vm.hostname = "chefhat.dev"
    config.vm.network "private_network", ip: "192.168.255.16", network: "255.255.0.0"

    # VirtualBox specific config - eg. composer memory problem
    config.vm.provider :virtualbox do |vb, override|
        override.vm.synced_folder ".", "/vagrant", :nfs => true
        vb.customize ["modifyvm", :id, "--rtcuseutc", "on"]
        vb.customize ["modifyvm", :id, "--memory", 1024]
        vb.customize ["modifyvm", :id, "--cpus", 1]
    end

    # fixed chef version to be sure that recipes are working
    config.omnibus.chef_version = :latest

    # chef recipes
    config.berkshelf.enabled = true
    config.berkshelf.berksfile_path = "./Berksfile"

    config.vm.provision "chef_solo" do |chef|
        chef.run_list = [
            "recipe[apt]",
            "recipe[chef-hat::base]",
            "recipe[chef-hat::php]",
            "recipe[chef-hat::composer]"
        ]
        chef.json = {}
    end

end
