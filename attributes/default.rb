default["php"]["ppa"]["uri"]        = "http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu"
default["php"]["ppa"]["key"]        = "E5267A6C"
default["php"]["ppa"]["key_server"] = "keyserver.ubuntu.com"
default["php"]["ppa"]["components"] = ["trusty", "main"]
default["php"]["conf_dir"]          = "/etc/php5/cli"
default["php"]["ext_conf_dir"]      = "/etc/php5/mods-available"
default["php"]["real_conf_dir"]     = "/etc/php5/cli/conf.d"

default["php"]["modules"]           = [
    "php5-common",
    "php5-cli",
    "php5-memcached",
    "php5-dev"
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