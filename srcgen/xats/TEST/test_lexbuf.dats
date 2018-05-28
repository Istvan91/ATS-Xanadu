(* ****** ****** *)
(*
** HX-2018-05-16
** Unit testing. Kind of.
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
#staload "./../SATS/lexbuf.sats"
//
(* ****** ****** *)

local
//
#include
"./../DATS/symbol.dats"
#include
"./../DATS/location.dats"
#include
"./../DATS/filepath.dats"
//
#include "./../DATS/lexbuf.dats"
//
in
  // nothing
end // end of [local]

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
//
val () =
println!
("Hello from [test_lexbuf]!")
//
(* ****** ****** *)

local
//
#staload
"./../SATS/location.sats"
//
#staload
"./../../util/SATS/cblist.sats"
#staload
"./../../util/SATS/Posix/cblist.sats"
#staload _ =
"./../../util/DATS/Posix/cblist.dats"
//
in
//
val
BSZ = i2sz(3)
val-
~Some_vt(cbs) =
fpath_get_cblist("./test_lexbuf.dats", BSZ)
//
var buf: lexbuf
var pos: position
//
val (_) = position_initize(pos, 0, 0, 0)
//
val (_) = lexbuf_initize_cblist(buf, cbs)
//
val (_) = println!(int2char0(lexbufpos_getinc_char(buf, pos)))
val (_) = println!(int2char0(lexbufpos_getinc_char(buf, pos)))
val (_) = println!(int2char0(lexbufpos_getinc_char(buf, pos)))
val (_) = println!(int2char0(lexbufpos_getinc_char(buf, pos)))
val (_) = println!(int2char0(lexbufpos_getinc_char(buf, pos)))
val (_) = println!(int2char0(lexbufpos_getinc_char(buf, pos)))
val (_) = println!(int2char0(lexbufpos_getinc_char(buf, pos)))
val (_) = println!(int2char0(lexbufpos_getinc_char(buf, pos)))
val (_) = println!(int2char0(lexbufpos_getinc_char(buf, pos)))
//
val (_) = println!("The first seg: ", lexbuf_get_fullseg(buf))
//
val (_) = println!(int2char0(lexbufpos_getinc_char(buf, pos)))
val (_) = println!(int2char0(lexbufpos_getinc_char(buf, pos)))
val (_) = println!(int2char0(lexbufpos_getinc_char(buf, pos)))
val (_) = println!(int2char0(lexbufpos_getinc_char(buf, pos)))
val (_) = println!(int2char0(lexbufpos_getinc_char(buf, pos)))
val (_) = println!(int2char0(lexbufpos_getinc_char(buf, pos)))
val (_) = println!(int2char0(lexbufpos_getinc_char(buf, pos)))
val (_) = println!(int2char0(lexbufpos_getinc_char(buf, pos)))
val (_) = println!(int2char0(lexbufpos_getinc_char(buf, pos)))
val (_) = println!(int2char0(lexbufpos_getinc_char(buf, pos)))
//
val (_) = println!("The second seg: ", lexbuf_get_fullseg(buf))
//
end // end of [local]

(* ****** ****** *)

implement main0() = ((*void*))

(* ****** ****** *)

(* end of [test_lexbuf.dats] *)
