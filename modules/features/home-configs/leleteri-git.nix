{...}: {
  # This is not per-user module, leleteri = GH username
  flake.homeModules.leleteriGit = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "leleteri";
          email = "229750936+leleteri@users.noreply.github.com";
        };

        credential.helper = "store";
      };
    };
  };
}
