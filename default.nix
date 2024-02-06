{ mkDerivation, base, colour, diagrams-lib, diagrams-svg, lib
, SVGFonts
}:
mkDerivation {
  pname = "FordCircles";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base colour diagrams-lib diagrams-svg SVGFonts
  ];
  license = "unknown";
  mainProgram = "FordCircles";
}
