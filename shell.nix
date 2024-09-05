{pkgs ? import <nixpkgs> {}}: let
  python = pkgs.python312;
  lib-path = with pkgs;
    lib.makeLibraryPath [
      libffi
    ];
  podmanSetupScript = let
    registriesConf = pkgs.writeText "registries.conf" ''
      [registries.search]
      registries = ['docker.io']
      [registries.block]
      registries = []
    '';
  in
    pkgs.writeScript "podman-setup" ''
      #!${pkgs.runtimeShell}
      # Dont overwrite customised configuration
      if ! test -f ~/.config/containers/policy.json; then
        install -Dm555 ${pkgs.skopeo.src}/default-policy.json ~/.config/containers/policy.json
      fi
      if ! test -f ~/.config/containers/registries.conf; then
        install -Dm555 ${registriesConf} ~/.config/containers/registries.conf
      fi
    '';
in
  with pkgs;
    mkShell {
      packages = with pkgs; [
        php
        podman-compose
        podman-tui
        podman
        runc
        conmon
        skopeo
        slirp4netns
        fuse-overlayfs
      ];
      buildInputs = with python312.pkgs; [
        pip
      ];
      shellHook = ''
        # Setup python
        SOURCE_DATE_EPOCH=$(date +%s)
        export "LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${lib-path}"
        VENV=.venv

        if test ! -d $VENV; then
          python -m venv $VENV
        fi
        source ./$VENV/bin/activate
        export PYTHONPATH=`pwd`/$VENV/${python.sitePackages}/:$PYTHONPATH
        pip install -r requirements.txt

        # Setup podman
        ${podmanSetupScript}
      '';
    }
