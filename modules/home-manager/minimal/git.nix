{ username, useremail, gitUsername ? username, ... }:
{
  programs = {
    git = {
      enable = true;
      settings.user = {
        name = gitUsername;
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
