{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.waydroid = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      self.nixosModules.waydroidBindMounts
    ];

    virtualisation.waydroid = {
      enable = true;
    };

    environment.systemPackages = [
      inputs.nur.legacyPackages.${pkgs.stdenv.hostPlatform.system}.repos.ataraxiasjel.waydroid-script
      self.packages.${pkgs.stdenv.hostPlatform.system}.waydroidSu
      pkgs.waydroid-helper
    ];
  };
}
