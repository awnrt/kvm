#!/bin/bash
set -x
source "/etc/libvirt/hooks/kvm.conf"

modprobe -r vfio_pci
modprobe -r vfio_iommu_type1
modprobe -r vfio

virsh nodedev-reattach $VIRSH_GPU_VIDEO
virsh nodedev-reattach $VIRSH_GPU_AUDIO

echo 1 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind

nvidia-xconfig --query-gpu-info > /dev/null 2>&1

echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind

modprobe nvidia_drm
modprobe nvidia_modeset
modprobe drm_kms_helper
modprobe nvidia
modprobe drm
modprobe nvidia_uvm

systemctl start sddm.service

echo 0000:00:14.0 > /sys/bus/pci/drivers/vfio-pci/unbind
echo 0000:00:14.0 > /sys/bus/pci/drivers/xhci_hcd/bind
