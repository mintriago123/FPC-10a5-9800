{ pkgs, ... }:
let
  fpcbep = pkgs.fetchzip {
    url = "https://download.lenovo.com/pccbbs/mobiles/r1slm01w.zip";
    hash = "sha256-/buXlp/WwL16dsdgrmNRxyudmdo9m1HWX0eeaARbI3Q=";
    stripRoot = false;
  };

  overlay = final: prev: {
    libfprint = prev.libfprint.overrideAttrs (attrs: {
      doCheck = false;
      patches = (attrs.patches or []) ++ [ ./fpcmoh.patch ];
      postPatch =
        (attrs.postPatch or "")
        + ''
          substituteInPlace meson.build \
            --replace-fail "find_library('fpcbep', required: true)" "find_library('fpcbep', required: true, dirs: '$out/lib')"
        '';
      preConfigure =
        (attrs.preConfigure or "")
        + ''
          install -D "${fpcbep}/FPC_driver_linux_27.26.23.39/install_fpc/libfpcbep.so" "$out/lib/libfpcbep.so"
        '';
      postInstall =
        (attrs.postInstall or "")
        + ''
          install -Dm644 "${fpcbep}/FPC_driver_linux_libfprint/install_libfprint/lib/udev/rules.d/60-libfprint-2-device-fpc.rules" "$out/lib/udev/rules.d/60-libfprint-2-device-fpc.rules"
          substituteInPlace "$out/lib/udev/rules.d/70-libfprint-2.rules" --replace-fail "/bin/sh" "${pkgs.runtimeShell}"
        '';
    });

    fprintd = prev.fprintd.overrideAttrs (attrs: {
      doCheck = false;
      nativeBuildInputs = (attrs.nativeBuildInputs or []) ++ attrs.nativeCheckInputs;
    });
  };
in
{
  nixpkgs.overlays = [ overlay ];
  services.fprintd.enable = true;
  services.udev.packages = [ pkgs.libfprint ];

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
}
