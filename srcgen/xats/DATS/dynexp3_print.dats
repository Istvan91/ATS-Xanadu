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
// Start Time: October, 2018
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

#staload "./../SATS/lexing.sats"

(* ****** ****** *)

#staload "./../SATS/dynexp0.sats"

(* ****** ****** *)
//
#staload "./../SATS/staexp2.sats"
#staload "./../SATS/statyp2.sats"
#staload "./../SATS/dynexp2.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/dynexp3.sats"
//
(* ****** ****** *)
//
implement
fprint_val<t2ype> = fprint_t2ype
implement
fprint_val<s2exp> = fprint_s2exp
//
implement
fprint_val<f2arg> = fprint_f2arg
implement
fprint_val<tq2arg> = fprint_tq2arg
//
(* ****** ****** *)
//
implement
fprint_val<d3exp> = fprint_d3exp
//
(* ****** ****** *)

implement
fprint_val<d3ecl> = fprint_d3ecl

(* ****** ****** *)
//
implement
print_d3exp(x0) =
fprint_d3exp(stdout_ref, x0) 
implement
prerr_d3exp(x0) =
fprint_d3exp(stdout_ref, x0) 
//
implement
fprint_d3exp
  (out, x0) =
(
case-
x0.node() of
//
| D3Eint(tok) =>
  fprint!(out, "D3Eint(", tok, ")")
| D3Echr(tok) =>
  fprint!(out, "D3Echr(", tok, ")")
| D3Eflt(tok) =>
  fprint!(out, "D3Eflt(", tok, ")")
| D3Estr(tok) =>
  fprint!(out, "D3Estr(", tok, ")")
//
| D3Evar(d2v) =>
  fprint!(out, "D3Evar(", d2v, ")")
//
| D3Enone0() =>
  fprint!(out, "D3Enone0(", ")")
| D3Enone1(d2e) =>
  fprint!(out, "D3Enone1(", d2e, ")")
//
)
//
(* ****** ****** *)
//
implement
print_d3ecl(x0) =
fprint_d3ecl(stdout_ref, x0) 
implement
prerr_d3ecl(x0) =
fprint_d3ecl(stdout_ref, x0) 
//
local

implement
fprint_val<f3undecl> = fprint_f3undecl

in(*in-of-local*)

implement
fprint_d3ecl
  (out, x0) =
(
//
case-
x0.node() of
| D3Cnone0() =>
  fprint!(out, "D3Cnone0(", ")")
| D3Cnone1(d2c) =>
  fprint!(out, "D3Cnone1(", d2c, ")")
| D3Cfundecl
  (knd, mopt, tqas, f3ds) =>
  fprint!
  ( out
  , "D3Cfundecl("
  , knd, "; ", mopt, "; ", tqas, "; ", f3ds, ")")
//
)
//
end // end of [local]

(* ****** ****** *)

implement
print_f3undecl(x0) =
fprint_f3undecl(stdout_ref, x0)
implement
prerr_f3undecl(x0) =
fprint_f3undecl(stderr_ref, x0)

implement
fprint_f3undecl
  (out, x0) = let
//
val+F3UNDECL(rcd) = x0
//
in
  fprint!
  ( out
  , "F3UNDECL@{"
  , ", nam=", rcd.nam
  , ", arg=", rcd.arg
  , ", res=", rcd.res
  , ", def=", rcd.def, ", wtp=", rcd.wtp, "}")
end // end of [fprint_f3undecl]

(* ****** ****** *)

(* end of [xats_dynexp3_print.dats] *)
