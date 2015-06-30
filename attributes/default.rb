default["php"]["ppa"]["uri"]        = "http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu"
default["php"]["ppa"]["key"]        = "E5267A6C"
default["php"]["ppa"]["key_server"] = "keyserver.ubuntu.com"

default["php"]["modules"] = [
    "php5-common",
    "php5-cli",
    "php5-memcached",
    "php5-dev"
]

default["php"]["config"] = []