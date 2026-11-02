{...}: {
  flake.nixosModules.niriBinds = {
    pkgs,
    lib,
    ...
  }: let
    noctalia = lib.getExe pkgs.noctalia;
  in {
    settings.binds = {
      "Mod+T".spawn-sh = ["kitty"];
      "Mod+B".spawn = ["vivaldi" "--password-store=gnome-libsecret" "%U"];
      "Mod+A".spawn = "nautilus";

      # Column and windowing
      "Mod+J".focus-column-left = _: {};
      "Mod+K".focus-column-right = _: {};

      "Mod+Shift+J".focus-window-down = _: {};
      "Mod+Shift+K".focus-window-up = _: {};

      "Mod+H".consume-or-expel-window-left = _: {};
      "Mod+L".consume-or-expel-window-right = _: {};
      "Mod+Shift+H".move-column-left = _: {};
      "Mod+Shift+L".move-column-right = _: {};

      "Mod+V".toggle-window-floating = _: {};
      "Mod+Shift+V".switch-focus-between-floating-and-tiling = _: {};

      "Mod+Q".close-window = _: {};
      "Mod+F".maximize-column = _: {};
      "Mod+Shift+F".fullscreen-window = _: {};
      "Mod+Shift+1".move-column-to-workspace = 1;
      "Mod+Shift+2".move-column-to-workspace = 2;
      "Mod+Shift+3".move-column-to-workspace = 3;
      "Mod+Shift+4".move-column-to-workspace = 4;
      "Mod+Shift+5".move-column-to-workspace = 5;
      "Mod+Shift+6".move-column-to-workspace = 6;
      "Mod+Shift+7".move-column-to-workspace = 7;
      "Mod+Shift+8".move-column-to-workspace = 8;
      "Mod+Shift+9".move-column-to-workspace = 9;

      "Mod+Ctrl+J".spawn = ["niri" "msg" "action" "move-floating-window" "-x" "+0" "-y" "+25"];
      "Mod+Ctrl+K".spawn = ["niri" "msg" "action" "move-floating-window" "-x" "+0" "-y" "-25"];
      "Mod+Ctrl+L".spawn = ["niri" "msg" "action" "move-floating-window" "-x" "+25" "-y" "+0"];
      "Mod+Ctrl+H".spawn = ["niri" "msg" "action" "move-floating-window" "-x" "-25" "-y" "+0"];

      # Workspaces
      "Mod+1".focus-workspace = 1;
      "Mod+2".focus-workspace = 2;
      "Mod+3".focus-workspace = 3;
      "Mod+4".focus-workspace = 4;
      "Mod+5".focus-workspace = 5;
      "Mod+6".focus-workspace = 6;
      "Mod+7".focus-workspace = 7;
      "Mod+8".focus-workspace = 8;
      "Mod+9".focus-workspace = 9;
      "Mod+WheelScrollUp"
                .focus-workspace-up = _: {cooldown-ms = 150;};
      "Mod+WheelScrollDown".
                focus-workspace-down = _: {cooldown-ms = 150;};

      # Gammarelay
      "Mod+Alt+Minus".spawn = ["busctl" "--user" "call" "rs.wl-gammarelay" "/" "rs.wl.gammarelay" "UpdateBrightness" "d" "--" "-0.1"];
      "Mod+Alt+Equal".spawn = ["busctl" "--user" "call" "rs.wl-gammarelay" "/" "rs.wl.gammarelay" "UpdateBrightness" "d" "+0.1"];
      "Mod+Alt+Backspace".spawn = ["busctl" "--user" "set-property" "rs.wl-gammarelay" "/" "rs.wl.gammarelay" "Brightness" "d" "1.0"];

      # Noctalia
      "Mod+S".spawn-sh = "${noctalia} msg panel-toggle launcher";
      "Mod+X".spawn-sh = "${noctalia} msg panel-toggle tordex/processes:panel name";
      "Mod+P".spawn-sh = "${noctalia} msg panel-toggle elijaharch/wl-screen-mirror:controls";
      "XF86Display".spawn = "${noctalia} msg panel-toggle elijaharch/wl-screen-mirror:controls";
      "Mod+Escape".spawn-sh = "${noctalia} msg panel-toggle session";
      "Mod+Space".spawn-sh = "${noctalia} msg settings-toggle";

      # Screenshot
      "Print".screenshot = _: {};
      "Ctrl+Print".screenshot-screen = _: {};
      "Alt+Print".screenshot-window = _: {};

      # Raise Volume
      "Mod+BracketRight".spawn = [
        (lib.getExe' pkgs.wireplumber "wpctl")
        "set-volume"
        "-l"
        "1.0"
        "@DEFAULT_AUDIO_SINK@"
        "5%+"
      ];
      "XF86AudioRaiseVolume".spawn = [
        (lib.getExe' pkgs.wireplumber "wpctl")
        "set-volume"
        "-l"
        "1.0"
        "@DEFAULT_AUDIO_SINK@"
        "5%+"
      ];
      # Lower volume
      "Mod+BracketLeft".spawn = [
        (lib.getExe' pkgs.wireplumber "wpctl")
        "set-volume"
        "@DEFAULT_AUDIO_SINK@"
        "5%-"
      ];
      "XF86AudioLowerVolume".spawn = [
        (lib.getExe' pkgs.wireplumber "wpctl")
        "set-volume"
        "@DEFAULT_AUDIO_SINK@"
        "5%-"
      ];
      # Mutes
      "XF86AudioMute".spawn = [
        (lib.getExe' pkgs.wireplumber "wpctl")
        "set-mute"
        "@DEFAULT_AUDIO_SINK@"
        "toggle"
      ];
      "XF86AudioMicMute".spawn = [
        (lib.getExe' pkgs.wireplumber "wpctl")
        "set-mute"
        "@DEFAULT_AUDIO_SOURCE@"
        "toggle"
      ];
      # Raise brightness
      "Mod+Equal".spawn = [
        (lib.getExe pkgs.brightnessctl)
        "set"
        "5%+"
      ];
      "XF86MonBrightnessUp".spawn = [
        (lib.getExe pkgs.brightnessctl)
        "set"
        "5%+"
      ];
      # Lower brightness
      "Mod+Minus".spawn = [
        (lib.getExe pkgs.brightnessctl)
        "set"
        "5%-"
      ];
      "XF86MonBrightnessDown".spawn = [
        (lib.getExe pkgs.brightnessctl)
        "set"
        "5%-"
      ];
      # Turn of monitors
      "Mod+Backspace".power-off-monitors = _: {};
      "XF86ScreenSaver".power-off-monitors = _: {};
    };
  };
}
