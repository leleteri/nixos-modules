{
  self,
  inputs,
  ...
}: {
  perSystem = {
    pkgs,
    system,
    lib,
    ...
  }: {
    packages.mySteam = pkgs.steam.override {
      extraEnv = {
        __NV_PRIME_RENDER_OFFLOAD = true;
        __VK_LAYER_NV_optimus = "NVIDIA_only";
        MANGOHUD = true;
        GAMESCOPE = true;
        OBS_VKCAPTURE = true;
      };
    };
  };
}
