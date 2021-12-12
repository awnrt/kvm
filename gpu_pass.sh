LIGHTGREEN='\033[1;32m'
LIGHTRED='\033[1;91m'
WHITE='\033[1;97m'
MAGENTA='\033[1;35m'
CYAN='\033[1;96m'
NoColor='\033[0m'

printf ${MAGENTA}"Installing QEMU...\n"
printf ${LIGHTGREEN}""

sudo pacman -S qemu libvirt edk2-ovmf virt-manager ebtables dnsmasq wget
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service
sudo systemctl enable virtlogd.socket
sudo systemctl start virtlogd.socket
sudo virsh net-autostart default
sudo virsh net-start default

clear

printf ${MAGENTA}"Installing hooks manager...\n"
printf ${LIGHTGREEN}""

sudo mkdir /etc/libvirt/hooks

sudo wget 'https://raw.githubusercontent.com/PassthroughPOST/VFIO-Tools/master/libvirt_hooks/qemu' \
     -O /etc/libvirt/hooks/qemu

sudo chmod +x /etc/libvirt/hooks/qemu

clear

printf ${MAGENTA}"Copying hooks into root directory...\n"
printf ${LIGHTGREEN}""

sudo mkdir /etc/libvirt/hooks/qemu.d
sudo mkdir /etc/libvirt/hooks/qemu.d/win10
sudo mkdir /etc/libvirt/hooks/qemu.d/win10/prepare
sudo mkdir /etc/libvirt/hooks/qemu.d/win10/prepare/begin
sudo mkdir /etc/libvirt/hooks/qemu.d/win10/release
sudo mkdir /etc/libvirt/hooks/qemu.d/win10/release/end

sudo cp Hooks/start.sh /etc/libvirt/hooks/qemu.d/win10/prepare/begin/
sudo cp Hooks/isolstart.sh /etc/libvirt/hooks/qemu.d/win10/prepare/begin/
sudo cp Hooks/revert.sh /etc/libvirt/hooks/qemu.d/win10/release/end/
sudo cp Hooks/isocpurevert.sh /etc/libvirt/hooks/qemu.d/win10/release/end/

printf ${MAGENTA}"Configuring kvm.conf...\n"
printf ${LIGHTGREEN}""

sudo cp Hooks/kvm.conf /etc/libvirt/hooks/

printf ${MAGENTA}"Defining Win10.xml...\n"
printf ${LIGHTGREEN}""

sudo virsh define win10.xml

printf ${LIGHTGREEN}"\nYou are done!\n"
printf ${LIGHTGREEN}""
