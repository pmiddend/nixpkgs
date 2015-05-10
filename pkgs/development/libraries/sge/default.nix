{ stdenv,
  fetchgit
, cmake-3_0
, boost
, fcppt
, awl
, mizuiro
, majutsu
, enablePng ? true
, libpng
, enableOpenGL ? true
, glew
, libXrandr
, libX11
, enableEvdev ? true
, libevdev
, enablePango ? true
, pango
, enableOpenAL ? true
, openalSoft }:

stdenv.mkDerivation rec {
  name = "sge-1.0";

  src = fetchgit {
    url = https://github.com/freundlich/spacegameengine.git;
    rev = "4e32613d70cd741c3bc9d56e5690c4073d5a8a99";
    sha256 = "1qhjnv172jpxmpq0pvb4w1g0wzzbra7pgafqw38wiizixm9qb24q";
  };

  buildInputs = [ cmake-3_0 boost fcppt awl mizuiro majutsu ] ++ stdenv.lib.optional enablePng libpng ++ stdenv.lib.optional enableOpenGL [ glew libXrandr libX11 ] ++ stdenv.lib.optional enableEvdev libevdev ++ stdenv.lib.optional enablePango pango ++ stdenv.lib.optional enableOpenAL openalSoft;
  configurePhase = ''
    modpath="$(echo "${fcppt}"/share/cmake/Modules);$(echo "${awl}"/share/cmake/Modules)"
    mkdir build && cd build
    cmake \
      -DCMAKE_INSTALL_PREFIX=$out \
      -DCMAKE_MODULE_PATH=$modpath \
      ..
  '';

  enableParallelBuilding = true;

  meta = {
    description = "insert description here";
    longDescription = ''
    insert long description here
    '';
    homepage = https://github.com/freundlich/spacegameengine;
    license = stdenv.lib.licenses.boost;
    /*maintainers = with stdenv.lib.maintainers; [ aforemny ];*/
  };
}
