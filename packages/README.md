# 自定义包

这里存放项目自己维护的 Nix 包定义。包放在这里并不会自动安装到任何系统或用户环境；需要在相应的配置中引用它。

## 配置原则

优先按用户安装；只有需要让一台主机的所有用户都能使用时，才考虑系统级安装：

1. **只给某个用户安装**：在 `parts/home.nix` 中找到对应的 Home Manager 配置（例如 `yang@home`），将包加入 `home.packages`。
2. **给单台主机的所有用户安装**：在 `hosts/<主机>/` 中将包加入 `environment.systemPackages`。
3. **多台主机需要相同的系统级安装**：将软件清单提取到 `modules/nixos/` 下的共享模块，再在 `parts/nixos.nix` 中把该模块加入需要它的主机的 `modules` 列表。`parts/nixos.nix` 负责组装主机配置，不直接维护软件清单。

## 在 Home Manager 用户配置中使用

例如，在 `parts/home.nix` 中某个用户配置的模块列表里添加模块：

```nix
({ pkgs, ... }: {
  home.packages = [
    (pkgs.callPackage ../packages/lark.nix { })
  ];
})
```

只需将包加入目标用户的 `home.packages`，即可限定该包只安装给这个用户。

## 在 NixOS 配置中使用

例如，要让 `home` 主机的所有用户都能使用该软件，在 `hosts/home/default.nix` 的现有配置中加入：

```nix
{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.callPackage ../../packages/lark.nix { })
  ];
}
```

如果多台主机都需要同样的配置，就把这段配置移到共享模块中，并按模块所在位置调整相对路径。

`pkgs.callPackage` 会根据包定义函数的参数自动传入 Nixpkgs 中的依赖。

## 包目录约定

简单的包可以直接放在此目录，例如 `packages/lark.nix`。包含本地安装文件或多个相关文件的包，建议使用独立目录，并以 `default.nix` 作为包定义入口：

```text
packages/
  tern/
    default.nix
    Tern-版本-linux-x86_64.tar.gz
```

这种目录形式同样使用 `callPackage`，将路径指向包目录即可：

```nix
(pkgs.callPackage ../packages/tern { })
```

Nix 会自动读取目录中的 `default.nix`。引用包时应确认目标系统与包兼容；例如只支持 Linux x86_64 的软件，不要添加到不兼容的 Darwin 或 ARM 配置中。

### Tern

Tern 的安装包需要从 Stencil 登录下载，压缩包保存在 `packages/tern/`，不提交到 Git。首次安装或清理 Nix store 后缺少安装包时，在仓库根目录运行：

```bash
nix-store --add-fixed sha256 packages/tern/Tern-0.9.36-linux-x86_64.tar.gz
```

`packages/tern/default.nix` 通过 `requireFile` 按文件名和 SHA-256 使用这份安装包。目前只在 `parts/home.nix` 的 `yang@home` 中启用。
