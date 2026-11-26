{
  lib,
  stdenvNoCC,
  stdenv,
  requireFile,
  autoPatchelfHook,
  copyDesktopItems,
  makeDesktopItem,
  libglvnd,
  libpulseaudio,
  libxcb,
  libxkbcommon,
  pam,
  vulkan-loader,
  wayland,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "tern";
  version = "0.9.36";

  src = requireFile {
    name = "Tern-${finalAttrs.version}-linux-x86_64.tar.gz";
    hash = "sha256-XEJvGCxnK0GotYbhDrCNXwUG6ZDEMfpHYZYcgt7/zzI=";
    message = ''
      Download Tern ${finalAttrs.version} from Stencil, then run:
        nix-store --add-fixed sha256 packages/tern/Tern-${finalAttrs.version}-linux-x86_64.tar.gz
    '';
  };

  strictDeps = true;
  nativeBuildInputs = [ autoPatchelfHook copyDesktopItems ];
  buildInputs = [ stdenv.cc.cc.lib ];

  # Tern loads its graphics, display and audio backends at runtime.
  runtimeDependencies = map lib.getLib [
    libglvnd
    libpulseaudio
    libxcb
    libxkbcommon
    pam
    vulkan-loader
    wayland
  ];

  dontBuild = true;
  dontStrip = true;
  installPhase = ''
    runHook preInstall
    install -Dm755 tern "$out/bin/tern"
    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "so.stencil.tern";
      desktopName = "Tern";
      exec = "tern";
      icon = "utilities-terminal";
      categories = [ "System" "TerminalEmulator" ];
    })
  ];

  meta = {
    description = "Terminal workspace by Stencil";
    homepage = "https://stencil.so/tern";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
    mainProgram = "tern";
  };
})
