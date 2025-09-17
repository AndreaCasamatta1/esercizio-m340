# -*- mode: ruby -*-
# vi: set ft=ruby :
BOX_IMAGE = "ubuntu/jammy64"

BASE_INT_NETWORK = "10.10.20"
BASE_HOST_ONLY_NETWORK = "192.168.56"

Vagrant.configure("2") do |config|
  config.vm.define "web.m340" do |web|
	web.vm.box = BOX_IMAGE
	web.vm.hostname = "web.m340"
	web.vm.network "private_network",
      ip: "#{BASE_INT_NETWORK}.10",
      virtualbox__intnet: "#{BASE_INT_NETWORK}"

	web.vm.network "private_network", ip: "#{BASE_HOST_ONLY_NETWORK}.10"

	# Mount automatico della cartella del sito e permessi directory, dmode e file, fmode
	web.vm.synced_folder "./sito", "/var/www/html",
      owner: "www-data", group: "www-data",
      mount_options: ["dmode=775,fmode=664"]

    web.vm.provision "shell", path: "configWeb.sh"

	web.vm.provider "virtualbox" do |vb|
      vb.name = "web.m340"
      vb.memory = 2048
      vb.cpus = 2
    end
  end

  config.vm.define "db.m340" do |db|
	db.vm.box = BOX_IMAGE
	db.vm.hostname = "db.m340"

	db.vm.network "private_network",
      ip: "#{BASE_INT_NETWORK}.11",
      virtualbox__intnet: "#{BASE_INT_NETWORK}"

	db.vm.provision "shell", path: "configDB.sh"

	db.vm.provider "virtualbox" do |vb|
      vb.name = "db.m340"
      vb.memory = 2048
      vb.cpus = 2
    end
  end
end
