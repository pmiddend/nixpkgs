{ stdenv, fetchgit, cmake-3_0, boost, fcppt, libX11 }:

stdenv.mkDerivation rec {
  name = "majutsu-1.0";

  src = fetchgit {
    url = https://github.com/freundlich/majutsu.git;
    rev = "0a77c56e3836f9d1b46373ca1af5e29741af0471";
    sha256 = "19a5qv1lny1l81rg28830803rvkbxnzqd2d5qvy4sq2pgsjk3yfb";
  };

  buildInputs = [ cmake-3_0 boost fcppt ];
  configurePhase = ''
    modpath="$(echo "${fcppt}"/share/cmake/Modules)"
    mkdir build && cd build
    cmake \
      -DCMAKE_INSTALL_PREFIX=$out \
      -DCMAKE_MODULE_PATH=$modpath \
      ..
  '';

  meta = {
    description = "insert description here";
    longDescription = ''
    insert long description here
    '';
    homepage = https://github.com/freundlich/majutsu;
    license = stdenv.lib.licenses.boost;
    /*maintainers = with stdenv.lib.maintainers; [ aforemny ];*/
  };
}
