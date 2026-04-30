{ config, pkgs, lib, dms, dgop, danksearch, niri, ... }:

{
  # Import DMS modules (niri is configured at NixOS level for DankGreeter)
  imports = [
    dms.homeModules.dank-material-shell
    dms.homeModules.niri
  ];

  # DankMaterialShell configuration
  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true;
    dgop.package = dgop.packages.${pkgs.system}.default;

    # Niri integration
    niri = {
      enableKeybinds = true;   # Sets static preset keybinds
      enableSpawn = true;      # Auto-start DMS with niri
      includes.enable = false; # Disable separate include files (use inline keybinds)
    };
  };

  # Niri screenshot keybind
  programs.niri.settings = {
    outputs = {
      # 这里的 "Virtual-1" 是虚拟机常见的显示器名称，强制设置 2K 分辨率
      "Virtual-1" = {
        mode = { width = 2560; height = 1440; };
        scale = 2.0;
      };
    };

    input = {
      keyboard = {
        xkb = {
          # ctrl:swap_lalt_lctl -> 交换左 Ctrl 和 左 Alt
          # ctrl:nocaps         -> 将 Caps Lock 变为额外的 Ctrl
          options = "ctrl:swap_lalt_lctl,ctrl:nocaps";
        };
      };
    };

    binds = {
      # Ctrl + Shift + A 截图并打开编辑窗口 (使用 swappy)
      "Ctrl+Shift+A".action.spawn = [
        "sh" "-c" "grim -g \"$(slurp)\" - | swappy -f -"
      ];
    };

    spawn-at-startup = [
      { command = [ "dbus-update-activation-environment" "--systemd" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP" ]; }
      { command = [ "systemctl" "--user" "start" "graphical-session.target" ]; }
    ];
  };

  # Swappy configuration
  xdg.configFile."swappy/config" = {
    text = ''
      [Default]
      save_dir=${config.home.homeDirectory}/Pictures/Screenshots
      save_filename_format=swappy-%Y-%m-%d-%H-%M-%S.png
      show_panel=true
      line_size_hint=3
      text_font=sans
      text_size=20
    '';
    force = true;
  };

  # Variety wallpaper changer configuration
  xdg.configFile."variety/variety.conf" = {
    text = ''
      [variety]
      change_enabled = True
      change_interval = 1800
      download_folder = ${config.home.homeDirectory}/Pictures/Wallpapers
      # Use the script for setting wallpaper
      set_wallpaper_script = True
      # Fallback/Custom command
      set_command = "${pkgs.swww}/bin/swww img \"%f\" --transition-type random --transition-duration 1"
      # Ensure variety uses the script/command
      users_set_command = True
      
      poses_enabled = True
      smart_notice_enabled = True
      smart_fetch_enabled = True

      [sources]
      src1 = True|folder|${config.home.homeDirectory}/Pictures/Wallpapers
      src2 = True|wallhaven|https://wallhaven.cc/search?categories=110&purity=100&atleast=3840x2160&sorting=random&order=desc&seed=EZTNL1&page=1
      src3 = True|wallhaven|https://wallhaven.cc/search?categories=111&purity=100&atleast=3840x2160&topRange=6M&sorting=hot&order=desc&page=1
    '';
    force = true;
  };

  # Variety set_wallpaper script for Wayland/swww
  xdg.configFile."variety/scripts/set_wallpaper" = {
    text = ''
      #!/usr/bin/env bash
      # Variety calls this script with the wallpaper path as $1
      
      if [[ -z "$1" ]]; then
          exit 1
      fi

      # Ensure swww-daemon is running
      if ! ${pkgs.procps}/bin/pgrep -x "swww-daemon" > /dev/null; then
          ${pkgs.swww}/bin/swww-daemon &
          sleep 1
      fi

      ${pkgs.swww}/bin/swww img "$1" --transition-type random --transition-duration 1
    '';
    executable = true;
    force = true;
  };

  # swww daemon for wallpaper (systemd user service)
  systemd.user.services.swww-daemon = {
    Unit = {
      Description = "swww wallpaper daemon";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      Restart = "on-failure";
      # Ensure WAYLAND_DISPLAY is available
      Environment = [ "PATH=${pkgs.swww}/bin" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  # Variety wallpaper changer autostart
  systemd.user.services.variety = {
    Unit = {
      Description = "Variety wallpaper changer";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" "swww-daemon.service" ];
    };
    Service = {
      ExecStart = "${pkgs.variety}/bin/variety --not-show-config";
      Restart = "on-failure";
      # Important for Wayland/Niri
      Environment = [ 
        "PATH=${lib.makeBinPath [ pkgs.variety pkgs.swww pkgs.coreutils pkgs.procps ]}"
      ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
