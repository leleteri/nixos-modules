{...}: {
  flake.nixosModules.generalEnvironment = {
    pkgs,
    lib,
    ...
  }: {
    services.libinput.enable = true;
    services.xserver.enable = true;
    services.xserver.displayManager.lightdm.enable = lib.mkForce false;

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber = {
        enable = true;
        extraConfig = {
          "99-disable-stream-restore" = {
            "wireplumber.profiles" = {
              main = {
                "hooks.stream.state" = "disabled";
              };
            };
          };
        };
      };
    };

    time.timeZone = "Asia/Jakarta";
    i18n.defaultLocale = "en_US.UTF-8";

    services.xserver.xkb = {
      layout = "us,ua";
      variant = "";
    };

    hardware.bluetooth.enable = true;
  };
}
