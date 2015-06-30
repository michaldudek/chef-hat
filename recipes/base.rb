packages_list = %w(
    git
    curl
    libssl-dev
    openssl
    screen
    nano
    sudo
    nfs-common
)

packages_list.each do |name| 
    package name do 
        action :install
    end
end
