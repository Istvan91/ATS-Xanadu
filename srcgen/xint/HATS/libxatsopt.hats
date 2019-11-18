(* ****** ****** *)
//
#staload
ERR =
"./../../xats/SATS/xerrory.sats"
//
(* ****** ****** *)
//
#staload
STM =
"./../../xats/SATS/stamp0.sats"
#staload
SYM =
"./../../xats/SATS/symbol.sats"
//
(* ****** ****** *)
//
#staload
FP0 =
"./../../xats/SATS/filpath.sats"
//
  typedef
  fpath_t = $FP0.filpath
  macdef
  dirbase =
  $FP0.filpath_dirbase
  macdef
  fpath_make = $FP0.filpath_make
//
(* ****** ****** *)
//
#staload
GLO =
"./../../xats/SATS/global.sats"
#staload
FS0 =
"./../../xats/SATS/filsrch.sats"
//
(* ****** ****** *)
//
#staload
"./../../xats/SATS/parsing.sats"
//
#staload
"./../../xats/SATS/synread.sats"
//
#staload
"./../../xats/SATS/trans01.sats"
#staload
"./../../xats/SATS/t1xread.sats"
//
#staload
"./../../xats/SATS/trans12.sats"
#staload
"./../../xats/SATS/t2xread.sats"
//
#staload
"./../../xats/SATS/trans23.sats"
#staload
"./../../xats/SATS/trans33.sats"
//
#staload
"./../../xats/SATS/t3xread.sats"
//
#staload
"./../../xats/SATS/trans3t.sats"
//
#staload
"./../../xats/SATS/intrep0.sats"
//
(* ****** ****** *)
//
#staload S2E =
"./../../xats/SATS/staexp2.sats"
#staload D2E =
"./../../xats/SATS/dynexp2.sats"
//
(* ****** ****** *)
//
#staload IR0 =
"./../../xats/SATS/intrep0.sats"
//
(* ****** ****** *)
//
#staload
_(*TMP*) =
"./../../xats/DATS/staexp0_print.dats"
#staload
_(*TMP*) =
"./../../xats/DATS/dynexp0_print.dats"
//
#staload
_(*TMP*) =
"./../../xats/DATS/staexp1_print.dats"
#staload
_(*TMP*) =
"./../../xats/DATS/dynexp1_print.dats"
//
#staload
_(*TMP*) =
"./../../xats/DATS/staexp2_print.dats"
#staload
_(*TMP*) =
"./../../xats/DATS/statyp2_print.dats"
#staload
_(*TMP*) =
"./../../xats/DATS/dynexp2_print.dats"
//
#staload
_(*TMP*) =
"./../../xats/DATS/dynexp3_print.dats"
//
(* ****** ****** *)
//
#staload
_(*TMP*) =
"./../../xats/DATS/intrep0_print.dats"
//
(* ****** ****** *)
//
#staload
_(*TMP*) =
"./../../xats/DATS/trans12_envmap.dats"
//
(* ****** ****** *)

(* end of [libxatsopt.hats] *)
