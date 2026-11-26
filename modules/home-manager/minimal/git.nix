{ username, useremail, lib, ... }:
{
  programs = {
    git = {
      enable = true;
      settings.user = {
        name = lib.mkDefault username;
        email = "${useremail}";
      };
    };

    gh = {
      enable = true;
      gitCredentialHelper = {
        enable = true;
      };
    };
  };
}
