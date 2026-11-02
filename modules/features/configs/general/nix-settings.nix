{...}: {
  flake.nixosModules.generalNixSettings = {
    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };

    nix.gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 15d";
    };

    nixpkgs.config.allowUnfree = true;
  };
}
