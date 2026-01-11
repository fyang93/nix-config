{ username, ... }:

{
  programs = {
    adb.enable = true;
  };

  # 用户在运行 adb 命令时，不需要每次都使用 sudo (有待测试)
  users.users."${username}" = {
    extraGroups = [
      "adbusers"
    ];
  };

}
