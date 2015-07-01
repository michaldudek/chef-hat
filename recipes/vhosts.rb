# require apache2 to be installed
include_recipe "apache2"
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_ssl"
include_recipe "apache2::mod_socache_shmcb"

# iterate over all defined vhosts and install them
node["vhosts"].each do |name, config|
    # create all necessary dirs for this host
     
    # the root dir
    # sometimes it may not be possible to create it (e.g.if its the same as shared dir on Vagrant)
    directory config["root_dir"] do
        owner "www-data"
        group "www-data"
        mode 0755
        action :create
        not_if do
            Dir.exists?(config["root_dir"])
        end
    end

    # doc root
    docroot = config["root_dir"];
    config["doc_root"].split('/').each do |dir|
        docroot = docroot + "/" + dir

        directory docroot do
            owner "www-data"
            group "www-data"
            mode 0755
            action :create
            not_if do
                Dir.exists?(docroot)
            end
        end
    end

    # log dir
    logdir = config["root_dir"]
    config["log_dir"].split('/').each do |dir|
        logdir = logdir + "/" + dir

        directory logdir do
            owner "www-data"
            group "www-data"
            mode 0775
            action :create
            not_if do
                Dir.exists?(logdir)
            end
        end
    end

    # choose proper template for the vhost
    if config["template"].nil?
        template_cookbook = "chef-hat"
        template_file = "vhost.erb"
    else
        template_cookbook = config["template"]["cookbook"].nil? ? "chef-hat" : config["template"]["cookbook"]
        template_file = config["template"]["file"].nil? ? "vhost.erb" : config["template"]["file"]
    end

    # decide on some variables
    port = config["port"].nil? ? 80 : config["port"]
    aliases = config["aliases"].nil? ? [] : config["aliases"]
    force_www = config["force_www"].nil? ? nil : config["force_www"]
    ssl = config["ssl"].nil? ? {"enabled" => false} : config["ssl"]

    # manage ssl certificate
    ssl = {
        enabled: (config["ssl"].nil? || config["ssl"]["enabled"].nil?) ? false : config["ssl"]["enabled"],
        cert_file: (config["ssl"].nil? || config["ssl"]["cert_file"].nil?) ? nil : config["ssl"]["cert_file"],
        cert_key_file: (config["ssl"].nil? || config["ssl"]["cert_key_file"].nil?) ? nil : config["ssl"]["cert_key_file"],
        cert_chain_file: (config["ssl"].nil? || config["ssl"]["cert_chain_file"].nil?) ? nil : config["ssl"]["cert_chain_file"]
    }
    if ssl[:enabled] == true
        # if ssl certificate is enabled, but none is specified then generate one
        if ssl[:cert_file].nil?
            cert = ssl_certificate config["host"] do
                common_name config["host"]
                country "UK"
                city "London"
                organization "Vagrant"
                department "Vagrant"
            end
            ssl[:cert_file] = cert.cert_path
            ssl[:cert_key_file] = cert.key_path
            ssl[:cert_chain_file] = cert.chain_path
        end
    end
    
    # finally install the vhost
    web_app name do
        cookbook template_cookbook
        template template_file
        host config["host"]
        aliases aliases
        port port
        docroot docroot
        logdir logdir
        force_www force_www
        ssl ssl
        notifies :reload, "service[apache2]"
    end
end