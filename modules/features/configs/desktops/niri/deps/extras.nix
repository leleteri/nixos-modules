{...}: {
  flake.nixosModules.niriExtraDeps = {
    config,
    pkgs,
    lib,
    ...
  }: let
    onAc = pkgs.writeShellScript "on-ac" ''
      for d in /sys/class/power_supply/*; do
        case "$(cat "$d/type" 2>/dev/null)" in
          Mains|USB) [ "$(cat "$d/online" 2>/dev/null)" = 1 ] && exit 0 ;;
        esac
      done
      exit 1
    '';

    ppctl = "${pkgs.power-profiles-daemon}/bin/powerprofilesctl";

    syncProfile = pkgs.writeShellScript "power-profile-sync" ''
      if ! ${onAc}; then
        ${ppctl} set power-saver
      fi
    '';
  in {
    environment.pathsToLink = [
      "/share/applications"
      "/share/xdg-desktop-portal"
      "/share/gsettings-schemas"
    ];

    systemd.services.power-profile-sync = {
      description = "Set power profile based on AC state";
      after = ["power-profiles-daemon.service"];
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = syncProfile;
      };
    };
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;

    services.udev.extraRules = ''
      ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", \
      TAG+="systemd", ENV{SYSTEMD_WANTS}="power-profile-sync.service"
    '';
  };
}
