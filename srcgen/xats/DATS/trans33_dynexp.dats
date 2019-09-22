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
// Author: Hongwei Xi
// Start Time: September, 2019
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

#staload "./../SATS/basics.sats"

(* ****** ****** *)

#staload "./../SATS/staexp2.sats"
#staload "./../SATS/statyp2.sats"
#staload "./../SATS/dynexp2.sats"
#staload "./../SATS/dynexp3.sats"

(* ****** ****** *)

#staload "./../SATS/trans23.sats"
#staload "./../SATS/trans33.sats"

(* ****** ****** *)

local

fun
auxsym0
( d3p0
: d3pat): d3pat =
let
//
val
loc0 = d3p0.loc()
val
t2p0 = d3p0.type()
val-
D3Psym0
(d1p1, dpis) = d3p0.node()
//
val () =
println!
("auxsym0: t2p0 = ", t2p0)
//
val opt0 =
match_d2pconlst_t2ype(dpis, t2p0)
//
in
case+ opt0 of
|
~None_vt() => d3p0
|
~Some_vt(d2i0) =>
 (
 case- d2i0 of
 | D2ITMcon(d2cs) =>
   (
   d3pat_make_node
   (loc0, t2p0, D3Pcon1(d2c1))
   ) where
   {
     val-
     list_cons(d2c1, _) = d2cs
     val _(*true*) =
     unify_d2con_t2ype(loc0, d2c1, t2p0)
   }
 )
end // end of [auxsym0]

(* ****** ****** *)

fun
auxdapp
( d3p0
: d3pat): d3pat =
let
//
val
loc0 = d3p0.loc()
val
t2p0 = d3p0.type()
//
val-
D3Pdapp
(d3f0, npf1, d3ps) = d3p0.node()
//
val
d3f0 = trans33_dpat(d3f0)
val
d3ps = trans33_dpatlst(d3ps)
//
in
  d3pat_make_node
  (loc0, t2p0, D3Pdapp(d3f0, npf1, d3ps))
end // end of [auxdapp]

in (* in-of-local *)

implement
trans33_dpat
  (d3p0) = let
(*
val loc0 = d3p0.loc()
*)
val ((*void*)) =
println!
("trans33_dpat: d3p0 = ", d3p0)
//
in
//
case+
d3p0.node() of
//
| D3Pany _ => d3p0
| D3Pvar _ => d3p0
//
| D3Psym0 _ => auxsym0(d3p0)
//
| D3Pdapp _ => auxdapp(d3p0)
//
| D3Pnone0 _ => d3p0
| D3Pnone1 _ => d3p0
//
| _ (* rest-of-d3pat *) => d3p0
//
end // end of [trans33_dpat]

end // end of [local]

(* ****** ****** *)

implement
trans33_dpatlst
  (d3ps) =
list_vt2t(d3ps) where
{
val
d3ps =
list_map<d3pat><d3pat>
  (d3ps) where
{
implement
list_map$fopr<d3pat><d3pat>(d3p) = trans33_dpat(d3p)
}
} (* end of [trans33_dpatlst] *)

(* ****** ****** *)

local

fun
auxcon2
( d3e0
: d3exp): d3exp =
let
//
val
loc0 = d3e0.loc()
val
t2p0 = d3e0.type()
val-
D3Econ2
(d2cs) = d3e0.node()
//
val () =
println!
("auxcon2: t2p0 = ", t2p0)
//
val opt0 =
match_d2conlst_t2ype(d2cs, t2p0)
//
in
//
case+ opt0 of
|
~None_vt() => d3e0
|
~Some_vt(d2c1) =>
 let
 val
 _(*true*) =
 unify_d2con_t2ype(loc0, d2c1, t2p0)
 in
 d3exp_make_node(loc0, t2p0, D3Econ1(d2c1))
 end
//
end // end of [auxcon2]

fun
auxcst2
( d3e0
: d3exp): d3exp =
let
//
val
loc0 = d3e0.loc()
val
t2p0 = d3e0.type()
val-
D3Ecst2
(d2cs) = d3e0.node()
//
val () =
println!
("auxcst2: t2p0 = ", t2p0)
//
val opt0 =
match_d2cstlst_t2ype(d2cs, t2p0)
//
in
//
case+ opt0 of
|
~None_vt() => d3e0
|
~Some_vt(d2c1) =>
 let
 val
 _(*true*) =
 unify_d2cst_t2ype(loc0, d2c1, t2p0)
 in
 d3exp_make_node(loc0, t2p0, D3Ecst1(d2c1))
 end
//
end // end of [auxcst2]

(* ****** ****** *)

fun
auxsym0
( d3e0
: d3exp): d3exp =
let
//
val
loc0 = d3e0.loc()
val
t2p0 = d3e0.type()
val-
D3Esym0
(d1e1, dpis) = d3e0.node()
//
val () =
println!
("auxsym0: t2p0 = ", t2p0)
//
val opt0 =
match_d2pitmlst_t2ype(dpis, t2p0)
//
in
case+ opt0 of
|
~None_vt() => d3e0
|
~Some_vt(d2i0) =>
 (
 case- d2i0 of
 | D2ITMvar(d2v1) =>
   (
   d3exp_make_node
   (loc0, t2p0, D3Evar(d2v1))
   ) where
   {
     val _(*true*) =
     unify_d2var_t2ype(loc0, d2v1, t2p0)
   }
 | D2ITMcon(d2cs) =>
   (
   d3exp_make_node
   (loc0, t2p0, D3Econ1(d2c1))
   ) where
   {
     val-
     list_cons(d2c1, _) = d2cs
     val _(*true*) =
     unify_d2con_t2ype(loc0, d2c1, t2p0)
   }
 | D2ITMcst(d2cs) =>
   (
   d3exp_make_node
   (loc0, t2p0, D3Ecst1(d2c1))
   ) where
   {
     val-
     list_cons(d2c1, _) = d2cs
     val _(*true*) =
     unify_d2cst_t2ype(loc0, d2c1, t2p0)
   }
 )
end // end of [auxsym0]

(* ****** ****** *)

fun
auxdapp
( d3e0
: d3exp): d3exp =
let
//
val
loc0 = d3e0.loc()
val
t2p0 = d3e0.type()
//
val-
D3Edapp
(d3f0, npf1, d3es) = d3e0.node()
//
val
d3f0 = trans33_dexp(d3f0)
val
d3es = trans33_dexplst(d3es)
//
in
  d3exp_make_node
  (loc0, t2p0, D3Edapp(d3f0, npf1, d3es))
end // end of [auxdapp]

(* ****** ****** *)

fun
aux_if0
( d3e0
: d3exp): d3exp = let
//
val
loc0 = d3e0.loc()
val
t2p0 = d3e0.type()
val-
D3Eif0
( d3e1
, d3e2, opt3) = d3e0.node()
//
val d3e1 = trans33_dexp(d3e1)
val d3e2 = trans33_dexp(d3e2)
val opt3 = trans33_dexpopt(opt3)
//
in
  d3exp_make_node
  (loc0, t2p0, D3Eif0(d3e1, d3e2, opt3))
end (* end of [aux_if0] *)

(* ****** ****** *)

fun
aux_lam
( d3e0
: d3exp): d3exp = let
//
val
loc0 = d3e0.loc()
val
t2p0 = d3e0.type()
val-
D3Elam
( f3as
, tres
, arrw, body) = d3e0.node()
//
val
f3as =
trans33_farglst(f3as)
val
body = trans33_dexp(body)
//
in
d3exp_make_node
(loc0, t2p0, D3Elam(f3as, tres, arrw, body))
end // end of [aux_lam]

(* ****** ****** *)

in (* in-of-local *)

implement
trans33_dexp
  (d3e0) = let
//
(*
val loc0 = d3e0.loc()
*)
val ((*void*)) =
println!
("trans33_dexp: d3e0 = ", d3e0)
//
in
//
case+
d3e0.node() of
//
| D3Eint _ => d3e0
| D3Ebtf _ => d3e0
| D3Echr _ => d3e0
| D3Eflt _ => d3e0
| D3Estr _ => d3e0
//
| D3Evar _ => d3e0
//
| D3Econ1 _ => d3e0
| D3Ecst1 _ => d3e0
//
| D3Econ2 _ => auxcon2(d3e0)
| D3Ecst2 _ => auxcst2(d3e0)
//
| D3Esym0 _ => auxsym0(d3e0)
//
| D3Edapp _ => auxdapp(d3e0)
//
| D3Eif0
  (_, _, _) => aux_if0(d3e0)
(*
| D3Ecase
  (_, _, _) => aux_case(d3e0)
*)
| D3Elam
  (_, _, _, _) => aux_lam(d3e0)
//
| D3Enone0 _ => d3e0
| D3Enone1 _ => d3e0
//
| _ (* rest-of-d3exp *) => d3e0
//
end // end of [trans33_dexp]

end // end of [local]

(* ****** ****** *)

implement
trans33_dexpopt
  (opt) =
(
case+ opt of
| None() => None()
| Some(d3e) => Some(trans33_dexp(d3e))
) (* end of [trans33_dexpopt] *)

implement
trans33_dexplst
  (d3es) =
list_vt2t(d3es) where
{
val
d3es =
list_map<d3exp><d3exp>
  (d3es) where
{
implement
list_map$fopr<d3exp><d3exp>(d3e) = trans33_dexp(d3e)
}
} (* end of [trans33_dexplst] *)

(* ****** ****** *)
//
implement
trans33_dgua
  (d3g0) =
let
val loc0 = d3g0.loc()
in
case+
d3g0.node() of
| D3GUAexp(d3e1) =>
  let
    val
    d3e1 = trans33_dexp(d3e1)
  in
    d3gua_make_node(loc0, D3GUAexp(d3e1))
  end
| D3GUAmat(d3e1, d3p2) =>
  let
    val d3e1 = trans33_dexp(d3e1)
    val d3p2 = trans33_dpat(d3p2)
  in
    d3gua_make_node(loc0, D3GUAmat(d3e1, d3p2))
  end
end
//
implement
trans33_dgualst
  (d3gs) =
list_vt2t(d3gs) where
{
val
d3gs =
list_map<d3gua><d3gua>
  (d3gs) where
{
  implement
  list_map$fopr<d3gua><d3gua>(d3g) = trans33_dgua(d3g)
}
} (* end of [trans33_dgualst] *)
//
(* ****** ****** *)
//
implement
trans33_farg
  (f3a0) =
(
case+
f3a0.node() of
| F3ARGsome_dyn
  (npf, d3ps) =>
  (
  f3arg_make_node
  ( f3a0.loc()
  , F3ARGsome_dyn(npf, d3ps))
  ) where
  {
    val
    d3ps = trans33_dpatlst(d3ps)
  }
//
| F3ARGsome_sta _ => f3a0
| F3ARGsome_met _ => f3a0
)
implement
trans33_farglst
  (f3as) =
list_vt2t(f3as) where
{
val
f3as =
list_map<f3arg><f3arg>
  (f3as) where
{
  implement
  list_map$fopr<f3arg><f3arg>(f3a) = trans33_farg(f3a)
}
} (* end of [trans33_farglst] *)
//
(* ****** ****** *)

local

fun
aux_valdecl
( d3c0
: d3ecl): d3ecl =
let
//
val-
D3Cvaldecl
( knd
, mopt
, v3ds) = d3c0.node()
//
fun
auxv3d0
( v3d0
: v3aldecl
)
: v3aldecl =
let
val+
V3ALDECL(rcd) = v3d0
//
val loc = rcd.loc
val pat = trans33_dpat(rcd.pat)
val def = trans33_dexpopt(rcd.def)
val wtp = rcd.wtp
//
in
V3ALDECL(@{loc=loc,pat=pat,def=def,wtp=wtp})
end // end of [auxv3d0]
and
auxv3ds
( v3ds
: v3aldeclist
)
: v3aldeclist =
list_vt2t
(
list_map<v3aldecl><v3aldecl>(v3ds)
) where
{
implement
list_map$fopr<v3aldecl><v3aldecl>(x0) = auxv3d0(x0)
}
//
in
  d3ecl_make_node
  (d3c0.loc(), D3Cvaldecl(knd, mopt, auxv3ds(v3ds)))
end // end of [aux_valdecl]

(* ****** ****** *)

fun
aux_fundecl
( d3c0
: d3ecl): d3ecl =
let
//
val-
D3Cfundecl
( knd
, mopt
, tqas, f3ds) = d3c0.node()
//
fun
auxf3d0
( f3d0
: f3undecl
)
: f3undecl =
let
val+
F3UNDECL(rcd) = f3d0
//
val loc = rcd.loc
val nam = rcd.nam
val a2g = rcd.a2g
val a3g = rcd.a3g
val res = rcd.res
val def = rcd.def
val wtp = rcd.wtp
val ctp = rcd.ctp
//
val a3g =
(
case+ a3g of
| None() => None()
| Some(f3as) =>
  Some(trans33_farglst(f3as))
) : f3arglstopt
val def =
trans33_dexpopt(def)
//
in
F3UNDECL
(
@{
 loc=loc,nam=nam
,a2g=a2g,a3g=a3g,res=res,def=def,wtp=wtp,ctp=ctp}
)(*F3UNDECL*)
end // end of [auxf3d0]
and
auxf3ds
( f3ds
: f3undeclist
)
: f3undeclist =
list_vt2t
(
list_map<f3undecl><f3undecl>(f3ds)
) where
{
implement
list_map$fopr<f3undecl><f3undecl>(x0) = auxf3d0(x0)
}
//
in
  d3ecl_make_node
  (d3c0.loc(), D3Cfundecl(knd, mopt, tqas, auxf3ds(f3ds)))
end // end of [aux_fundecl]

in (* in-of-local *)

implement
trans33_decl
  (d3c0) = let
//
(*
val loc0 = d3c0.loc()
*)
val ((*void*)) =
println!
("trans33_decl: d3c0 = ", d3c0)
//
in
//
case+
d3c0.node() of
//
| D3Cd2ecl _ => d3c0
//
| D3Cvaldecl _ =>
  (
    aux_valdecl(d3c0)
  )
//
| D3Cfundecl _ =>
  (
    aux_fundecl(d3c0)
  )
//
| D3Cnone0 _ => d3c0
| D3Cnone1 _ => d3c0
| _ (* rest-of-d3ecl *) => d3c0
//
end // end of [trans33_decl]

end // end of [local]

(* ****** ****** *)

implement
trans33_declist
  (d3cs) =
list_vt2t(d3cs) where
{
val
d3cs =
list_map<d3ecl><d3ecl>
  (d3cs) where
{
implement
list_map$fopr<d3ecl><d3ecl>(d3c) = trans33_decl(d3c)
}
} (* end of [trans33_declist] *)

(* ****** ****** *)

(* end of [xats_trans33_dynexp.dats] *)