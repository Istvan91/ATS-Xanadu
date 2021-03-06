(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Xanadu - Unleashing the Potential of Types!
** Copyright (C) 2018 Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi
// Start Time: September, 2019
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)

#staload "./staexp1.sats"
#staload "./dynexp1.sats"

(* ****** ****** *)

#staload "./staexp2.sats"
#staload "./statyp2.sats"
#staload "./dynexp2.sats"
#staload "./dynexp3.sats"

(* ****** ****** *)
//
typedef
treader23
(a:t@ype) = (a) -> void
//
(* ****** ****** *)
//
datatype trerr23 =
//
| TRERR23d3pat of (d3pat)
| TRERR23d3exp of (d3exp)
//
| TRERR23f3arg of (f3arg)
| TRERR23d3ecl of (d3ecl)
//
typedef
trerr23lst = List0(trerr23)
//
(* ****** ****** *)
//
fun//{}
trerr23_add(trerr23): void
//
(* ****** ****** *)
//
fun
tread23_program
  (prog: d3eclist): void
//
(* ****** ****** *)
//
fun//{}
tread23_d3exp: treader23(d3exp)
fun//{}
tread23_d3explst: treader23(d3explst)
//
(* ****** ****** *)
//
fun//{}
tread23_d3ecl: treader23(d3ecl)
fun//{}
tread23_d3eclist: treader23(d3eclist)
//
(* ****** ****** *)

(* end of [xats_tread23.sats] *)
