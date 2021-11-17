sudo pacman -S qemu libvirt edk2-ovmf virt-manager ebtables dnsmasq
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service
sudo systemctl enable virtlogd.socket
sudo systemctl start virtlogd.socket
sudo virsh net-autostart default
sudo virsh net-start default
