{
  stdenv,
  cmake,
  spdlog,
  ...
}:
stdenv.mkDerivation {
  name = "template-lib";
  src = ./.;
  nativeBuildInputs = [ cmake ];
  buildInputs = [ spdlog ];
}