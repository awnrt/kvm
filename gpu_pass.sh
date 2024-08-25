WORKDIRECTORY=$PWD
PERMUSER="awy"

if [ "$EUID" -ne 0 ]
  then printf "The script has to be run as root.\n"
  exit
fi

doas -u $PERMUSER mkdir -p /home/$PERMUSER/.local/share/vgabios
doas -u $PERMUSER cp $WORKDIRECTORY/Hooks/patch.rom /home/$PERMUSER/.local/share/vgabios

#pacman -S qemu libvirt edk2-ovmf virt-manager ebtables dnsmasq wget qemu-ui-sdl qemu-ui-gtk
#systemctl enable libvirtd.service
#systemctl start libvirtd.service
#systemctl enable virtlogd.socket
#systemctl start virtlogd.socket
#virsh net-autostart default
#virsh net-start default

pacman -Sy --noconfirm
pacman -S qemu-desktop libvirt libvirt-openrc edk2-ovmf virt-manager dnsmasq wget --noconfirm

mkdir /etc/libvirt/hooks

#wget 'https://raw.githubusercontent.com/PassthroughPOST/VFIO-Tools/master/libvirt_hooks/qemu' \
#     -O /etc/libvirt/hooks/qemu
cp $WORKDIRECTORY/Hooks/qemu /etc/libvirt/hooks/

chmod +x /etc/libvirt/hooks/qemu

mkdir -p /etc/libvirt/hooks/qemu.d/win10-hidden-pt/prepare/begin
mkdir -p /etc/libvirt/hooks/qemu.d/win10-hidden-pt/release/end

cp $WORKDIRECTORY/Hooks/start.sh /etc/libvirt/hooks/qemu.d/win10-hidden-pt/prepare/begin/
#sudo cp Hooks/isolstart.sh /etc/libvirt/hooks/qemu.d/win10/prepare/begin/
cp $WORKDIRECTORY/Hooks/revert.sh /etc/libvirt/hooks/qemu.d/win10-hidden-pt/release/end/
#sudo cp Hooks/isocpurevert.sh /etc/libvirt/hooks/qemu.d/win10/release/end/
cp Hooks/kvm.conf /etc/libvirt/hooks/

usermod -aG libvirt,kvm,input,audio,video $PERMUSER
