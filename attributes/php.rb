default["php"]["ppa"]["uri"]        = "http://ppa.launchpad.net/ondrej/php/ubuntu"
default["php"]["ppa"]["key"]        = "E5267A6C"
default["php"]["ppa"]["key_server"] = "keyserver.ubuntu.com"
default["php"]["ppa"]["components"] = ["xenial", "main"]
default["php"]["conf_dir"]          = "/etc/php/5.6/cli"
default["php"]["ext_conf_dir"]      = "/etc/php/5.6/mods-available"
default["php"]["real_conf_dir"]     = "/etc/php/5.6/cli/conf.d"

default["php"]["redis"]["repository"] = "https://github.com/phpredis/phpredis.git"
default["php"]["redis"]["version"]  = "master"

default["php"]["modules"]           = [
    "php5.6",
    "php-gettext",
    "php5.6-mbstring",
    "libapache2-mod-php5.6",
    "php5.6-dev",
    "php5.6-mcrypt",
    "php5.6-curl",
    "php5.6-cli",
    "php5.6-gd",
    "php5.6-intl",
    "php5.6-zip",
    "php5.6-imagick",
    "php5.6-memcached",
    "php-pear"
]

# php.ini

default["php"]["config"]["expose_php"]          = "Off"
default["php"]["config"]["enable_dl"]           = "Off"

default["php"]["config"]["max_execution_time"]  = 30
default["php"]["config"]["max_input_time"]      = 60
default["php"]["config"]["memory_limit"]        = "128M"
default["php"]["config"]["upload_max_filesize"] = "50M"
default["php"]["config"]["max_file_uploads"]    = "20"

default["php"]["config"]["date.timezone"]       = "Europe/London"

default["php"]["config"]["error_reporting"]     = "E_ALL & ~E_DEPRECATED & ~E_STRICT"
default["php"]["config"]["display_errors"]      = "Off"
default["php"]["config"]["error_log"]           = ""

default["php"]["config"]["SMTP"]                = "localhost"
default["php"]["config"]["smtp_port"]           = 25
default["php"]["config"]["mail.add_x_header"]   = "On"
default["php"]["config"]["sendmail_path"]       = "/usr/sbin/sendmail -t -i"

default["php"]["config"]["custom"]              = []

default["php"]["config"]["opcache"]["enable"]   = 1
default["php"]["config"]["opcache"]["enable_cli"] = 0
default["php"]["config"]["opcache"]["memory_consumption"] = 256 # dont be afraid to increase it a lot
default["php"]["config"]["opcache"]["interned_strings_buffer"] = 16 # increase if app relies on annotations
default["php"]["config"]["opcache"]["max_accelerated_files"] = 50000
default["php"]["config"]["opcache"]["max_wasted_percentage"] = 5
default["php"]["config"]["opcache"]["validate_timestamps"] = 1 # should be 0 for production
default["php"]["config"]["opcache"]["revalidate_freq"] = 2 # more? ignored if validate_timestamps is 0
default["php"]["config"]["opcache"]["revalidate_path"] = 0 
default["php"]["config"]["opcache"]["dups_fix"] = 0
default["php"]["config"]["opcache"]["max_file_size"] = 0
default["php"]["config"]["opcache"]["force_restart_timeout"] = 180
default["php"]["config"]["opcache"]["error_log"] = ""
default["php"]["config"]["opcache"]["log_verbosity_level"] = 1

# xdebug

default["php"]["xdebug"]                        = []
