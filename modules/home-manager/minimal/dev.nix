{ pkgs, ... }:
{
  home.packages = with pkgs; [
    just
    uv
    bun
    nodejs_24
    pnpm
    
    # LSP: https://opencode.ai/docs/lsp/
    pyright
    deno
    nixd
  ];
}
