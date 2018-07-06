(* ****** ****** *)
(*
** HX-2018-06-30
** Testing. Kind of.
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

local
//
#include
"./../../util/DATS/cblist.dats"
#include
"./../../util/DATS/Posix/cblist.dats"
//
in
  // nothing
end // end of [local]

(* ****** ****** *)

local
//
(* ****** ****** *)
//
#include
"./../DATS/basics.dats"
//
#include
"./../DATS/symbol.dats"
#include
"./../DATS/location.dats"
#include
"./../DATS/filepath.dats"
//
(* ****** ****** *)
//
#include"./../DATS/lexbuf.dats"
//
#include"./../DATS/lexing_token.dats"
#include"./../DATS/lexing_kword.dats"
//
#include"./../DATS/lexing_util0.dats"
//
(* ****** ****** *)
//
#include"./../DATS/staexp0.dats"
#include"./../DATS/staexp0_print.dats"
//
(* ****** ****** *)
//
#include"./../DATS/parsing_tokbuf.dats"
//
#include"./../DATS/parsing_basics.dats"
//
#include"./../DATS/parsing_staexp.dats"
//
#include"./../DATS/parsing_dynexp.dats"
//
(* ****** ****** *)
//
in
  // nothing
end // end of [local]

(* ****** ****** *)

implement
main0() =
{
//
val () =
println!
("Hello from [test_xats_main]!")
//
} (* end of [main0] *)

(* ****** ****** *)
//
#staload "./../SATS/lexing.sats"
//
#staload "./../SATS/staexp0.sats"
#staload "./../SATS/dynexp0.sats"
//
#staload "./../SATS/parsing.sats"
//
(* ****** ****** *)
//
val-
toks =
(
string_tokenize
("\
...\n\
$X.@ a b c ($A.d, $A.e)\n\
prop type t0ype view viewtype viewt0ype")
)
//
val
toks =
lexing_preprocess_tokenlst(toks)
//
val
toks =
list_vt2t(toks)
val ((*void*)) =
list0_foreach<token>
(g0ofg1(toks), lam(tok) => fprint_token(stdout_ref, tok))
//
val s0t0 = let
//
var err: int
var buf: tokbuf
val ((*void*)) = (err := 0)
val ((*void*)) =
tokbuf_initize_list(buf, toks)
//
in
  p_sort0(buf, err)
end // end of [val]

val () = println! ("s0t0 = ", s0t0)

(* ****** ****** *)

(* end of [test_xats_main.dats] *)