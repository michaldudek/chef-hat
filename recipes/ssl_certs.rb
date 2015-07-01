include_recipe "openssl"

node["ssl_certs"].each do |name, config|
    openssl_x509 config["path"] do
        common_name name
        org "Vagrant"
        org_unit "Vagrant"
        country "UK"
        expire 3650 # 10 years
    end
end
