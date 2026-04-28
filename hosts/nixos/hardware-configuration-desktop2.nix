# NOTE: Run `sudo nixos-generate-config` on desktop2 and copy the generated
# /etc/nixos/hardware-configuration.nix content to this file.
{
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };
}