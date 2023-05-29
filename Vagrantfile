# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "debian/bullseye64"
  config.vm.box_version = ">= 11.0.0"

  config.vm.network "private_network", type: "dhcp"

  config.vm.hostname = "wildflydomain"

  config.vm.network "forwarded_port", guest: 8081, host: 8081
  config.vm.network "forwarded_port", guest: 9991, host: 9991
  config.vm.network "forwarded_port", guest: 8082, host: 8082
  config.vm.network "forwarded_port", guest: 9992, host: 9992
  config.vm.network "forwarded_port", guest: 8083, host: 8083
  config.vm.network "forwarded_port", guest: 9993, host: 9993
  
  config.vm.provider "virtualbox" do |vb|
    vb.name = "Debian_Bullseye"
    vb.memory = "4096"
    vb.cpus = 4
  end

  config.vm.provision :docker

  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get install -y docker-compose
  SHELL

end
