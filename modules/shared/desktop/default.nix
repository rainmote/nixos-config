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
  };

  # Swappy configuration
  xdg.configFile."swappy/config".text = ''
    [Default]
    save_dir=${config.home.homeDirectory}/Pictures/Screenshots
    save_filename_format=swappy-%Y-%m-%d-%H-%M-%S.png
    show_panel=true
    line_size_hint=3
    text_font=sans
    text_size=20
  '';

  # Variety wallpaper changer configuration
  xdg.configFile."variety/variety.conf".text = ''
    [variety]
    sources = wallhaven
    wallhaven_url = https://wallhaven.cc/search?categories=111&purity=100&atleast=3840x2160&topRange=6M&sorting=hot&order=desc
    wallhaven_url2 = https://wallhaven.cc/search?categories=110&purity=100&atleast=3840x2160&sorting=random&order=desc&seed=EZTNL1
    download_folder = ${config.home.homeDirectory}/Pictures/Wallpapers
    change_enabled = True
    change_interval = 30
    set_command = swww img %f --transition-type random --transition-duration 1
    poses_enabled = True
    smart_notice_enabled = True
    smart_fetch_enabled = True
  '';

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
      ExecStart = "${pkgs.variety}/bin/variety";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}