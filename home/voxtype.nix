{ inputs, pkgs, ... }:

{
  programs.voxtype = {
    enable = true;
    package = inputs.voxtype.packages.${pkgs.stdenv.hostPlatform.system}.onnx;

    model.name = "base.en";

    service.enable = true;

    settings = {
      hotkey.enabled = false;

      whisper.language = "en";

      output = {
        mode = "type";
        fallback_to_clipboard = true;
      };
    };
  };
}
