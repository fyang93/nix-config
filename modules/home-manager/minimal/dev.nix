{ pkgs, ... }:
{
  home.packages = with pkgs; [
    just
    uv
    bun
    
    # LSP: https://opencode.ai/docs/lsp/
    pyright
    deno
    nixd
  ];
}
