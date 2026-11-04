{...}: {
  flake.homeModules.swayidleNiri = {
    pkgs,
    lib,
    ...
  }: let
    noctalia = lib.getExe pkgs.noctalia;
    niri = lib.getExe pkgs.niri;
    loginctl = lib.getExe' pkgs.systemd "loginctl";
    ifActive = name: cmd:
      toString (pkgs.writeShellScript name ''
        [ "$("${loginctl}" show-session "$XDG_SESSION_ID" -p Active --value)" = yes ] || exit 0
        ${cmd}
      '');
  in {
    services.swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 300;
          command = ifActive "idle-monitors-dim" "${pkgs.brightnessctl}/bin/brightnessctl -s set 1%";
          resumeCommand = "${pkgs.brightnessctl}/bin/brightnessctl -r";
        }
        {
          timeout = 315;
          command = ifActive "idle-monitors-off" "${niri} msg action power-off-monitors";
          resumeCommand = "${niri} msg action power-on-monitors";
        }
        {
          timeout = 330;
          command = "${noctalia} msg session lock";
        }
        {
          timeout = 900;
          command = ifActive "idle-suspend" "${noctalia} msg session lock-and-suspend";
        }
      ];
    };
  };
}
