#!/usr/bin/env nix-shell
#!nix-shell -i fontforge -p fontforge
Open($1)
Generate($1:r + ".svg")
