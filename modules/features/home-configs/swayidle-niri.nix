{...}: {
  flake.homeModules.swayidleNiri = {
    pkgs,
    lib,
    ...
  }: let
    noctalia = lib.getExe pkgs.noctalia;
    niri = lib.getExe pkgs.niri;
    loginctl = lib.getExe' pkgs.systemd "loginctl";
    sleep = lib.getExe' pkgs.coreutils "sleep";

    isActiveCheck = ''[ "$("${loginctl}" show-session "$XDG_SESSION_ID" -p Active --value)" = "yes" ]'';

    ifActive = name: cmd:
      toString (pkgs.writeShellScript name ''
        ${isActiveCheck} || exit 0
        ${cmd}
      '');

    beforeSleep = toString (pkgs.writeShellScript "swayidle-before-sleep" ''
      LOCK_FLAG="''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/noctalia-pending-lock"
      if ${isActiveCheck}; then
        "${noctalia}" msg session lock
      else
        touch "$LOCK_FLAG"
      fi
    '');

    afterResume = toString (pkgs.writeShellScript "swayidle-after-resume" ''
      LOCK_FLAG="''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/noctalia-pending-lock"
      if [ -f "$LOCK_FLAG" ]; then
        while ! ${isActiveCheck}; do
          ${sleep} 0.2
        done
        ${sleep} 0.5
        rm -f "$LOCK_FLAG"
        "${noctalia}" msg session lock
      fi
    '');
  in {
    services.swayidle = {
      enable = true;
      events = {
        before-sleep = beforeSleep;
        after-resume = afterResume;
      };
      timeouts = [
        {
          timeout = 300;
          command = "${pkgs.brightnessctl}/bin/brightnessctl -s set 1%";
          resumeCommand = "${pkgs.brightnessctl}/bin/brightnessctl -r";
        }
        {
          timeout = 315;
          command = "${niri} msg action power-off-monitors";
          resumeCommand = "${niri} msg action power-on-monitors";
        }
        {
          timeout = 330;
          command = ifActive "idle-lock" "${noctalia} msg session lock";
        }
        {
          timeout = 900;
          command = ifActive "idle-suspend" "${noctalia} msg session lock-and-suspend";
        }
      ];
    };
  };
}
