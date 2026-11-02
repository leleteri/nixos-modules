{inputs, ...}: {
  flake.nixosModules.homeManager = {pkgs, ...}: {
    imports = [inputs.home-manager.nixosModules.default];
    home-manager = {
      extraSpecialArgs = {inherit inputs;};
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "hmbak";
    };
  };
}
