{ pkgs, ... }:
{
  home.packages = with pkgs; [
    just
    uv
    bun
    nodejs_22

    gnumake
    gcc
    
    # LSP: https://opencode.ai/docs/lsp/
    pyright
    deno
    nixd
  ];
}
