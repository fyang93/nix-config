{ username, useremail, ... }:
{
  programs = {
    git = {
      enable = true;
      settings.user = {
        name = "${username}";
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
