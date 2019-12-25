(* ****** ****** *)
(*
** for lin-streams
*)
(* ****** ****** *)

(*
#staload
"./../SATS/stream_vt.sats"
*)


(* ****** ****** *)
//
impltmp
<a>(*tmp*)
stream_vt_nil() =
$llazy(strmcon_vt_nil())
impltmp
<a>(*tmp*)
stream_vt_cons
  (x0, xs) =
(
$llazy(strmcon_vt_cons(x0, xs))
)
//
(* ****** ****** *)
//
impltmp
<a>(*tmp*)
stream_vt_sing(x0) =
stream_vt_cons(x0, stream_vt_nil())
impltmp
<a>(*tmp*)
stream_vt_pair(x0, y0) =
stream_vt_cons(x0, stream_vt_sing(y0))
//  
(* ****** ****** *)
//
impltmp
<a>(*tmp*)
stream_vt_extend
  (xs, x0) =
(
stream_vt_append(xs, stream_vt_sing(x0))
)
//
(* ****** ****** *)

impltmp
<a>(*tmp*)
stream_vt_append
  (xs, ys) =
(
  append(xs, ys)
) where
{
fun
append(xs, ys) =
$llazy
(
case+ $eval(xs) of
| ~strmcon_vt_nil() => $eval(ys)
| ~strmcon_vt_cons(x0, xs) =>
   strmcon_vt_cons(x0, append(xs, ys))
)
} (* end of [stream_vt_append] *)

(* ****** ****** *)

impltmp
<x0><y0>
stream_vt_map
  (xs) =
(
  auxmain(xs)
) where
{
fun
auxmain(xs) =
$llazy
(
case+ $eval(xs) of
| ~strmcon_vt_nil() =>
   strmcon_vt_nil()
| ~strmcon_vt_cons(x0, xs) =>
   strmcon_vt_cons(map$fopr0(x0), auxmain(xs))
)
} (* end of [stream_vt_map] *)

(* ****** ****** *)

impltmp
<x0>(*tmp*)
stream_vt_filter
  (xs) =
(
  auxmain(xs)
) where
{
fnx
auxmain(xs) =
$llazy
(auxloop($eval(xs)))
and
auxloop
( xs
: strmcon_vt(x0)
)
: strmcon_vt(x0) =
(
case+ xs of
|
~strmcon_vt_nil() =>
 strmcon_vt_nil()
|
~strmcon_cons(x0, xs) =>
(
 if
 filter$test0<x0>(x0)
 then
 strmcon_vt_cons(x0, auxmain(xs)) else auxloop($eval(xs))
)
)
} (* end of [stream_vt_filter] *)

(* ****** ****** *)

(* end of [stream_vt.dats] *)
