(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Xanadu - Unleashing the Potential of Types!
** Copyright (C) 2020 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// HX-2020-03-21:
// It is time to start a code diary:
// This is really just a potpourri of my own code for all sorts of uses.
// Please use it for whatever purpose you see fit.
//
(* ****** ****** *)
//
// HX-2020-03-21:
// Zoe has started learning programming in Python. Maybe in ATS later :)
// One of her exercises is to reverse the digits of a four digit number.
//
(* ****** ****** *)
//
#extern
fun<>
digitize$base
  ((*void*)): sintgt(0)
//
#extern
fun<>
gint_digitize_sint
{n:nat}
(n0: sint(n)): list_vt(sint)
//
(* ****** ****** *)
//
#extern
fun<>
rdigitize$base
  ((*void*)): sintgt(0)
//
#extern
fun<>
gint_rdigitize_sint
{n:nat}
(n0: sint(n)): stream_vt(sint)
//
(* ****** ****** *)
//
#symload
digitize with gint_digitize_sint
#symload
rdigitize with gint_rdigitize_sint
//
(* ****** ****** *)
//
impltmp
<>(*tmp*)
digitize$base((*void*)) = 10
impltmp
<>(*tmp*)
rdigitize$base((*void*)) = 10
//
(* ****** ****** *)

impltmp
<>(*tmp*)
gint_digitize_sint
  (n0) =
(
loop(n0, list_vt_nil())
) where
{
//
val
b0 = digitize$base<>()
//
typedef
digitseq = list_vt(sint)
//
fun
loop
{n:nat}
( n0
: sint(n)
, r0
: digitseq): digitseq =
(
if
(n0 = 0)
then (r0)
else let
  val d0 =
  gint_mod_sint_sint(n0, b0)
in
loop(n0 / b0, list_vt_cons(d0, r0))
end
)
//
} (* end of [gint_digitize_sint] *)

(* ****** ****** *)

impltmp
<>(*tmp*)
gint_rdigitize_sint
  (n0) =
( auxmain(n0) ) where
{
//
val
b0 = rdigitize$base<>()
//
typedef
digitseq = stream_vt(sint)
//
fun
auxmain
{n:nat}
( n0
: sint(n)): digitseq =
$llazy
(
if
(n0 = 0)
then strmcon_vt_nil()
else let
val d0 =
gint_mod_sint_sint(n0, b0)
in
strmcon_vt_cons(d0, auxmain(n0/b0))
end // end of [else] // end-of-if
)
//
} (* end of [gint_rdigitize_sint] *)

(* ****** ****** *)

(* end of [mygist.dats] *)