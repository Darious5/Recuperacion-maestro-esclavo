Vagrant.configure("2") do |config|
  # Configuración para tierra (maestro)
  config.vm.define "tierra" do |tierra|
    tierra.vm.box = "debian/bullseye64"
    tierra.vm.network "private_network", ip: "192.168.57.103"
    tierra.vm.hostname = "tierra.sistema.test"
    tierra.vm.provision "shell", inline: <<-SHELL
      apt update && apt install -y bind9 bind9utils bind9-doc
      systemctl restart bind9
      SHELL
  end

  # Configuración para venus (esclavo)
  config.vm.define "venus" do |venus|
    venus.vm.box = "debian/bullseye64"
    venus.vm.network "private_network", ip: "192.168.57.102"
    venus.vm.hostname = "venus.sistema.test"
    venus.vm.provision "shell", inline: <<-SHELL
      apt update && apt install -y bind9 bind9utils bind9-doc
      systemctl restart bind9
    SHELL
  end
end