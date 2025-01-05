Vagrant.configure("2") do |config|
  config.vm.define "tierra" do |tierra|
    tierra.vm.box = "debian/bullseye64"
    tierra.vm.network "private_network", ip: "192.168.57.103"
    tierra.vm.hostname = "tierra.sistema.test"
    tierra.vm.provision "shell", inline: <<-SHELL
      apt update && apt install -y bind9 bind9utils bind9-doc
      
      echo 'OPTIONS="-4"' > /etc/default/bind9
      systemctl restart bind9

      mkdir -p /etc/bind/zones

      cp /vagrant/config/named.conf.options /etc/bind/named.conf.options
      cp /vagrant/config/named.conf.local.master /etc/bind/named.conf.local
      cp /vagrant/config/zones/sistema.test.zone /etc/bind/zones/sistema.test.zone
      cp /vagrant/config/zones/57.168.192.in-addr.arpa.zone /etc/bind/zones/57.168.192.in-addr.arpa.zone

      systemctl restart bind9
    SHELL
  end

  config.vm.define "venus" do |venus|
    venus.vm.box = "debian/bullseye64"
    venus.vm.network "private_network", ip: "192.168.57.102"
    venus.vm.hostname = "venus.sistema.test"
    venus.vm.provision "shell", inline: <<-SHELL
      apt update && apt install -y bind9 bind9utils bind9-doc

      echo 'OPTIONS="-4"' > /etc/default/bind9
      systemctl restart bind9

      cp /vagrant/config/named.conf.options /etc/bind/named.conf.options
      cp /vagrant/config/named.conf.local.slave /etc/bind/named.conf.local

      systemctl restart bind9
    SHELL
  end
end
