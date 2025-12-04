# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
 
  config.vm.box = "debian/bullseye64"
  config.vm.network "private_network", ip: "192.168.56.10"
  
  # Sincroniza el directorio local con la VM
  config.vm.synced_folder ".", "/vagrant", disabled: false

  config.vm.synced_folder "./web", "/var/www/juanma-davids.test/html", owner: "www-data", group: "www-data", mount_options: ["dmode=755", "fmode=644"]

  # Provisionamiento automático
  config.vm.provision "shell", path: "bootstrap.sh"
end
