{
  self,
  inputs,
  ...
}: {
  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages.myFish = inputs.wrapper-modules.wrappers.fish.wrap {
      inherit pkgs;
      plugins = with pkgs.fishPlugins; [
        autopair
        bobthefisher
        colored-man-pages
      ];
      shellAliases = {
        ls = lib.getExe pkgs.lsd;
        ff = lib.getExe self'.packages.owoFastfetch;
        l = "ls -lah";
      };
      runtimePkgs = [pkgs.git];
    };
  };
}
