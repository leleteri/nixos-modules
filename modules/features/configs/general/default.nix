{self, ...}: {
  flake.nixosModules.generalConfigurations = {
    imports = [
      self.nixosModules.generalHardware
      self.nixosModules.generalNetworking
      self.nixosModules.generalNixSettings
      self.nixosModules.generalEnvironment
    ];
  };
}
