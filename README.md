chef-hat
========

What's a Chef without their hat? This is a general-purpose Chef Cookbook with common recipes related to web development
in PHP.

Please note that this cookbook has been only _manually tested_ on Ubuntu 14.04 (should also work on Debian 7.0). For
testing details and environment check the [Vagrantfile](Vagrantfile).

## Installation

Even though this cookbook isn't available in [Berkshelf Supermarket](http://api.berkshelf.com/) you still can install
it using Berkshelf by adding it to your `Berksfile` like that:

    cookbook "chef-hat", git: "https://github.com/michaldudek/chef-hat.git", tag: "0.3.1"

# Usage

In general this cookbook is very opinionated and will install and configure packages that I use very often and found
an optimal configuration for their use. However, a lot is based on configurable attributes, so you can adjust to your
own needs.

## PHP

This cookbook will install PHP 5.6 from [Ondřej Surý PPA](https://launchpad.net/~ondrej/+archive/ubuntu/php5-5.6) and
make it work under Apache 2.4. Both Apache and the CLI will use the same PHP instance and the same configuration.

## VHosts

You can use this cookbook to manage Apache2 VirtualHosts and there is a quite powerful, configurable and flexible
[template](templates/default/vhost.erb).

It will automatically configure your hostname to work with `www.` subdomain and without and enforce one or the other.
You can configure as many aliases as you want. You can also enforce an HTTPS connection and for dev purposes an SSL
certificate can be generated and self-signed (or you can provide your own).

- - - 

# Recipes

Below is a list of all recipes in the cookbook and instructions on how to use them.

### chef-hat::base

Installs several useful packages like `git`, `curl`, `screen` or `nano` and some more.

### chef-hat::php

Installs PHP 5.6 from [Ondřej Surý PPA](https://launchpad.net/~ondrej/+archive/ubuntu/php5-5.6) with some additional
standard modules and creates a `php.ini` file based on the node attributes.

Check [attributes/php.rb](attributes/php.rb) for list of possible options. All are namespaced under `php` key.

### chef-hat::php-apache2

Add this recipe to your run list if you want to enable PHP 5.6 in your Apache2 server. It will also make Apache and CLI
use the same configuration of PHP with a shared `php.ini` file.

You should use this recipe instead of calling `apache2::mod_php5` directly in your `run_list`.

### chef-hat::php-composer

Installs [Composer](https://getcomposer.org/) globally.

### chef-hat::php-mongo

Installs [mongo extension](https://pecl.php.net/package/mongo) from PECL.

### chef-hat::php-redis

Installs [phpredis](https://github.com/phpredis/phpredis.git) extension (the recommended PHP Redis client).

You can configure what version to install with a node attribute `node["php"]["redis"]["version"]`.

### chef-hat::php-xdebug

Installs xdebug. You can configure it by adding appropriate settings to `node["php"]["xdebug"]` attribute.

### chef-hat::vhosts

This recipe will install as many Apache VirtualHosts as you define under `node["vhosts"]` attribute.

The `node["vhosts"]` attribute is a hash map of VirtualHosts configurations indexed by their filenames. An example
configuration can look like this:

    {
        "vhosts": {
            "100-chefhat": {
                "host": "chefhat.dev",
                "root_dir": "/var/www/chefhat",
                "log_dir": "logs",
                "doc_root": "public",
                "force_www": "yes",
                "ssl": {
                    "enabled": true
                }
            }
        }
    }

This will add and enable an apache2 site under `/etc/apache2/sites-available/100-chefhat.conf` and make it accessible
under both `chefhat.dev` and `www.chefhat.dev` hostnames. It will also enforce an HTTPS connection and will generate
the needed SSL self-signed certificate. The `DocumentRoot` will be `/var/www/chefhat/public` and there will be a log dir
created in `/var/www/chefhat/logs` with `apache_access.log` and `apache_error.log` in it. The `"force_www": "yes"`
setting will enforce `www.` in front of the host.

As you can see this short configuration snippet is quite powerful and takes care of many aspects that are often
forgotten when setting up vhosts.

Below is a list of all possible configuration options:

| Attribute                 | Default       | Description                        |
|:--------------------------|:--------------|:-----------------------------------|
| host                      | _required_    | `ServerName` for the host. If it doesn't start with `www.` then a `ServerAlias` will be added for it with `www.` and if it does start with `www.` then a `ServerAlias` will be generated without `www.`.
| port                      | `80`          | Port on which the Apache2 should listen. For SSL it will always be `443`.
| aliases                   | *none*        | List of `ServerAlias` entries to add. Just an array of strings.
| root_dir                  | _required_    | Path to the root directory of your web application. This usually isn't the same as `DocumentRoot` but one level (or more) higher. If it doesn't exist, it will be created and chowned to `www-data:www-data`.
| log_dir                   | `""`          | Directory in which Apache logs will be put. Relative to `root_dir` and should be inside it. If it doesn't exist, it will be created and chowned to `www-data:www-data`.
| doc_root                  | `""`          | `DocumentRoot` for the web application. Relative to `root_dir` and should be inside it. If it doesn't exist, it will be created and chowned to `www-data:www-data`.
| force_www                 | `nil`         | Should a `www.` be forced in front of the hostname? Possible options: `yes` - will force every visitor to be redirected to `www.[host]`; `no_www` - will force every visitor to be redirected to `[host]` without `www.` in front. Setting to anything else will be ignored.
| template.cookbook         | `chef-hat`    | If you want to use an alternate VirtualHost template then specify the cookbook name in which it is located. Keep in mind that if you do this, none of these options will work, unless the template implements them itself.
| template.file             | `vhost.erb`   | If you want to use an alternate VirtualHost template then specify the template file. Keep in mind that if you do this, none of these options will work, unless the template implements them itself.
| ssl.enabled               | `false`       | Should SSL connections be enabled for this VirtualHost? If `true` then the HTTPS connection will be enforced on all visitors.
| ssl.cert_file             | `nil`         | If you want to use your SSL certificate then specify its location here (it should be already on node). If `ssl.enabled` will be set to `true`, but no `ssl.cert_file` given, then a self-signed certificate will be automatically generated and used.
| ssl.cert_key_file         | `nil`         | Your certificate key file location. See above.
| ssl.cert_chain_file       | `nil`         | Your certificate chain file location. See above.

- - -

# Contributing

Feel free to fork and contribute to this repository. I'm open to any suggestions.

# License

[License is MIT](LICENSE.md).