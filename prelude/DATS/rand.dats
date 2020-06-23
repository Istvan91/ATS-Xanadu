(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Xanadu - Unleashing the Potential of Types!
** Copyright (C) 2019 Hongwei Xi, ATS Trustful Software, Inc.
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
// For random values
//
(* ****** ****** *)
//
// Author: Hongwei Xi
// Start Time: June, 2020
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)

impltmp
rand<bool>() =
let
val tf =
rand_nint_limit(2)
in
if
(tf > 0)
then true else false
end

(* ****** ****** *)

impltmp
rand<char>() =
let
val n0 =
rand_nint_limit(256)
in
char_make_sint
( if
  (n0<128)
  then n0 else n0-256 )
end

(* ****** ****** *)
//
impltmp
<a>(*tmp*)
rand_list() =
rand_list_length<a>
(rand_list$length<>())
//
impltmp
{a:t0}
rand<list_vt(a)>() =
list_vt2t(rand_list<a>())
impltmp
{a:vt}
rand<list_vt(a)> = rand_list<a>
//
(* ****** ****** *)
//
(*
HX-2020-06-22:
the default [16]
is randomly chosen
*)
//
impltmp
<>(*tmp*)
rand_list$length() =
(rand_nint_limit<>(16))
//
(* ****** ****** *)
//
impltmp
<a>(*tmp*)
rand_list_length
( ln ) =
(
gint_map_list_nint<a>(ln)
) where
{
impltmp
map$fopr<int><a>(_) = rand<a>()
}
//
(* ****** ****** *)
//
impltmp
<>(*tmp*)
rand_string() =
rand_string_length<>
(rand_string$length<>())
//
impltmp
rand<string>() =
string_vt2t(rand_string<>())
impltmp
rand<string_vt> = rand_string<>
//
(* ****** ****** *)

(* end of [rand.dats] *)
