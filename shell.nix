{pkgs ? import <nixpkgs> {}}: let
  python = pkgs.python312;
  lib-path = with pkgs;
    lib.makeLibraryPath [
      libffi
    ];
in
  with pkgs;
    mkShell {
      packages = with pkgs; [
        php
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
      '';
    }
