{ pkgs, ... }:

{
  xdg.desktopEntries.zathura = {
    name = "Zathura";
    comment = "Lightweight PDF viewer";
    exec = "${pkgs.zathura}/bin/zathura %f";
    terminal = false;
    type = "Application";
    categories = [ "Office" "Viewer" ];
    mimeType = [ "application/pdf" ];
  };
}
