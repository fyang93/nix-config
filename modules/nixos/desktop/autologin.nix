let
  username = "yang";
in
{
  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = username;
  };
}
