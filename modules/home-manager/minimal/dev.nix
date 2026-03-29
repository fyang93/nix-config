{ pkgs, ... }:
{
  home.packages = with pkgs; [
    just
    uv
    bun
    nodejs_22
    
    # LSP: https://opencode.ai/docs/lsp/
    pyright
    deno
    nixd
  ];
}
