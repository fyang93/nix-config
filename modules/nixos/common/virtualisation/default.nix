{ pkgs, username, ...  }:
{
  imports = [
    ./docker.nix
  ];

  virtualisation = {
    #### QEMU (Make sure you run this once: "sudo virsh net-autostart default")
    libvirtd = {
      enable = true;
      # hanging this option to false may cause file permission issues for existing guests.
      # To fix these, manually change ownership of affected files in /var/lib/libvirt/qemu to qemu-libvirtd.
      qemu.runAsRoot = true;
    };
  };

  users.users.${username}.extraGroups = [ "kvm" "libvirtd" ];
  networking.firewall.trustedInterfaces = [ "virbr0" ]; # required for virtual machine to access virtio network

  environment.systemPackages = with pkgs; [
    # Need to add [File (in the menu bar) -> Add connection] when start for the first time
    virt-manager

    # QEMU/KVM, provides:
    #   qemu-storage-daemon qemu-edid qemu-ga
    #   qemu-pr-helper qemu-nbd elf2dmp qemu-img qemu-io
    #   qemu-kvm qemu-system-x86_64 qemu-system-aarch64 qemu-system-i386
    qemu_kvm

    # 在虚拟机上启用 virtio 设备需要在主机上安装 virtiofsd 包
    # 参考 https://access.redhat.com/documentation/zh-cn/red_hat_enterprise_linux/9/html/configuring_and_managing_virtualization/sharing-files-between-the-host-and-its-virtual-machines-using-virtio-fs_sharing-files-between-the-host-and-its-virtual-machines
    virtiofsd
  ];

  # Enable nested virsualization, required by security containers and nested vm.
  # boot.extraModprobeConfig = "options kvm_intel nested=1"; # for intel cpu
  boot.extraModprobeConfig = "options kvm_amd nested=1";  # for amd cpu
}
