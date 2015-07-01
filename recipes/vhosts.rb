# require apache2 to be installed
include_recipe "apache2"

# enable some modules by default
apache_module "ssl" do
    enable true
end

apache_module "socache_shmcb" do
    enable true
end

apache_module "rewrite" do
    enable true
end

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

    # finally install the vhost
    if config["template"].nil?
        template_cookbook = "chef-hat"
        template_file = "vhost.erb"
    else
        template_cookbook = config["template"]["cookbook"].nil? ? "chef-hat" : config["template"]["cookbook"]
        template_file = config["template"]["file"].nil? ? "vhost.erb" : config["template"]["file"]
    end

    port = config["port"].nil? ? 80 : config["port"]
    aliases = config["aliases"].nil? ? [] : config["aliases"]
    force_www = config["force_www"].nil? ? nil : config["force_www"]
    
    web_app name do
        cookbook template_cookbook
        template template_file
        host config["host"]
        aliases aliases
        port port
        docroot docroot
        logdir logdir
        force_www force_www
        ssl config["ssl"]
        notifies :reload, "service[apache2]"
    end
end