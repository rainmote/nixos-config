{ config, pkgs, ... }:

{
  # Graphics hardware support
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Load NVIDIA driver
  services.xserver.videoDrivers = [ "nvidia" ];

  # NVIDIA driver configuration
  hardware.nvidia = {
    # Modesetting for Wayland/niri
    modesetting.enable = true;

    # Power management (10 series recommended off)
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    # Proprietary driver (10 series must be false)
    open = false;

    # NVIDIA settings menu
    nvidiaSettings = true;

    # Stable driver for GTX 1060
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Kernel parameter for Wayland framebuffer compatibility
  boot.kernelParams = [ "nvidia-drm.fbdev=1" ];

  # Environment variables for NVIDIA + Wayland
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}