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
// Start Time: August, 2019
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

#staload "./../SATS/label0.sats"
#staload "./../SATS/symbol.sats"

(* ****** ****** *)

#staload "./../SATS/locinfo.sats"

(* ****** ****** *)

#staload "./../SATS/staexp1.sats"
#staload "./../SATS/dynexp1.sats"

(* ****** ****** *)

#staload "./../SATS/staexp2.sats"
#staload "./../SATS/statyp2.sats"
#staload "./../SATS/dynexp2.sats"
#staload "./../SATS/dynexp3.sats"

(* ****** ****** *)

#staload "./../SATS/trans12.sats"
#staload "./../SATS/trans23.sats"

(* ****** ****** *)

implement
t2xtv_occurs
(xtv0, t2p0) =
(auxt2p0(t2p0)) where
{
//
fun
auxt2p0
(t2p0: t2ype): bool = (
//
case+
t2p0.node() of
//
| T2Pbas _ => false
//
| T2Pcst _ => false
| T2Pvar _ => false
//
| T2Pfc2 _ => false
//
| T2Pnone0 _ => false
| T2Pnone1 _ => false
//
| T2Pxtv(xtv1) =>
  if
  (xtv0 = xtv1)
  then true
  else auxt2p0(xtv1.type())
//
| T2Papp(t2p1, t2ps) =>
  (auxt2p0(t2p1) || auxt2ps(t2ps))
//
| T2Plam(s2vs, t2p1) => auxt2p0(t2p1)
//
| T2Pfun
  (fc2, npf, t2ps, t2p1) =>
  (auxt2p0(t2p1) || auxt2ps(t2ps))
//
| T2Pexi(s2vs, t2p1) => auxt2p0(t2p1)
| T2Puni(s2vs, t2p1) => auxt2p0(t2p1)
//
| T2Ptyext
  (tnm, t2ps) => auxt2ps(t2ps)
//
| T2Ptyrec
  (knd, npf, lt2ps) => auxlt2ps(lt2ps)
//
) (* end of [auxt2p0] *)
and
auxt2ps
(t2ps: t2ypelst): bool =
(
case+ t2ps of
| list_nil() => false
| list_cons(t2p0, t2ps) =>
  if auxt2p0(t2p0) then true else auxt2ps(t2ps)
)
//
and
auxlt2ps
(ltps: labt2ypelst): bool =
(
case+ ltps of
| list_nil() => false
| list_cons(lt2p0, ltps1) =>
  let
  val+TLABELED(lab, t2p0) = lt2p0
  in
  if auxt2p0(t2p0) then true else auxlt2ps(ltps1)
  end
)
//
} (* end of [t2xtv_occurs] *)

(* ****** ****** *)

implement
t2ype_tq2as_elim
(loc0, t2p0, tqas) =
(
case+ tqas of
|
list_nil() => t2p0
|
list_cons _ =>
let
val s2vs =
list_vt_nil((*void*))
val tsub =
list_vt_nil((*void*))
in
  auxinst1(tqas, s2vs, tsub)
end
) where
{
//
vtypedef
t2ypelst_vt = List0_vt(t2ype)
//
fnx
auxinst1
( tqas
: tq2arglst
, s2vs: s2varlst_vt
, tsub: t2ypelst_vt): t2ype =
(
case+ tqas of
| list_nil() =>
  ( t2p0 ) where
  {
  val
  s2vs = list_vt_reverse(s2vs)
  val
  tsub = list_vt_reverse(tsub)
  val
  t2p0 =
  (
  t2ype_substs(t2p0, s2vs, tsub)
  ) where
  {
    val s2vs = $UN.list_vt2t(s2vs)
    val tsub = $UN.list_vt2t(tsub)
  }
  val ((*void*)) = list_vt_free(s2vs)
  val ((*void*)) = list_vt_free(tsub)
  }
| list_cons(tqa0, tqas) =>
  (
    auxinst2(tqa0.s2vs(), tqas, s2vs, tsub)
  )
) (* end of [auxinst1] *)
and
auxinst2
( svs1
: s2varlst
, tqas
: tq2arglst
, svs2: s2varlst_vt
, tsub: t2ypelst_vt): t2ype =
(
case+ svs1 of
| list_nil() =>
  (
    auxinst1(tqas, svs2, tsub)
  )
| list_cons(s2v1, svs1) =>
  let
    val
    s2t1 = s2v1.sort()
    val
    xtv1 = t2xtv_new(loc0)
    val
    t2px =
    t2ype_srt_xtv(s2t1, xtv1)
    val
    svs2 = list_vt_cons(s2v1, svs2)
    val
    tsub = list_vt_cons(t2px, tsub)
  in
    auxinst2(svs1, tqas, svs2, tsub)
  end
) (* end of [auxinst2] *)
} (* end of [t2ype_tq2as_elim] *)
//
(* ****** ****** *)
//
implement
t2ype_tq2as_elim2
(loc0, t2p0, tqas) =
(
case+ tqas of
|
list_nil() =>
(TI3ARGnone(), t2p0)
|
list_cons _ =>
let
val
s2vs =
list_vt_nil((*void*)) 
val
tsub =
list_vt_nil((*void*)) 
val
(t2ps, t2p0) =
auxinst1(tqas, s2vs, tsub)
in
  (TI3ARGsome(t2ps), t2p0)
end
) where
{
//
vtypedef
t2ypelst_vt = List0_vt(t2ype)
//
fnx
auxinst1
( tqas
: tq2arglst
, s2vs: s2varlst_vt
, tsub: t2ypelst_vt
) : (t2ypelst, t2ype) =
(
case+ tqas of
| list_nil() =>
  (tsub, t2p0) where
  {
  val
  s2vs = list_vt_reverse(s2vs)
  val
  tsub =
  list_vt2t(list_vt_reverse(tsub))
  val
  t2p0 =
  (
  t2ype_substs(t2p0, s2vs, tsub)
  ) where
  {
    val s2vs = $UN.list_vt2t(s2vs)
  }
  val ((*void*)) = list_vt_free(s2vs)
  }
| list_cons(tqa0, tqas) =>
  (
    auxinst2(tqa0.s2vs(), tqas, s2vs, tsub)
  )
) (* end of [auxinst1] *)
and
auxinst2
( svs1
: s2varlst
, tqas
: tq2arglst
, svs2: s2varlst_vt
, tsub: t2ypelst_vt
) : (t2ypelst, t2ype) =
(
case+ svs1 of
| list_nil() =>
  (
    auxinst1(tqas, svs2, tsub)
  )
| list_cons(s2v1, svs1) =>
  let
    val
    s2t1 = s2v1.sort()
    val
    xtv1 = t2xtv_new(loc0)
    val
    t2px =
    t2ype_srt_xtv(s2t1, xtv1)
    val
    svs2 = list_vt_cons(s2v1, svs2)
    val
    tsub = list_vt_cons(t2px, tsub)
  in
    auxinst2(svs1, tqas, svs2, tsub)
  end
) (* end of [auxinst2] *)
} (* end of [t2ype_tq2as_elim2] *)
//
(* ****** ****** *)

implement
unify_t2ype_t2ype
(loc0, t2p1, t2p2) =
(
let
//
val
t2p1 = hnfize(t2p1)
and
t2p2 = hnfize(t2p2)
//
(*
val () =
println!("unify: loc0 = ", loc0)
val () =
println!("unify: t2p1 = ", t2p1)
val () =
println!("unify: t2p2 = ", t2p2)
*)
//
in (* in-of-let *)
case+
t2p1.node() of
| T2Pxtv(xtv1) =>
  auxtv1(xtv1, t2p2)
| _ (* else *) =>
  (
  case+
  t2p2.node() of
  | T2Pxtv(xtv2) =>
    auxtv2(t2p1, xtv2)
  | _ (* else *) => auxtp0(t2p1, t2p2)
  )
end where
{
//
fun
auxtp0
( t2p1: t2ype
, t2p2: t2ype): bool =
(
case+
t2p1.node() of
| T2Pexi(s2vs, t2p1) =>
  (
    auxtp0(t2p1, t2p2)
  )
| T2Puni(s2vs, t2p1) =>
  (
    auxtp0(t2p1, t2p2)
  ) where
  {
    val tsub =
    (
    list_map<s2var><t2ype>(s2vs)
    ) where
    {
      implement
      list_map$fopr<s2var><t2ype>(s2v) =
      t2ype_srt_xtv(s2v.sort(), t2xtv_new(loc0))
    }
    val t2p1 =
    t2ype_substs
    (t2p1, s2vs, $UN.list_vt2t(tsub))
    val ((*void*)) = list_vt_free(tsub)
  }
//
| _ (* non-quantifier *) =>
  (
  case+ t2p2.node() of
  | T2Puni(s2vs, t2p2) =>
    (
      auxtp0(t2p1, t2p2)
    )
  | T2Pexi(s2vs, t2p2) =>
    (
      auxtp0(t2p1, t2p2)
    ) where
    {
      val tsub =
      (
      list_map<s2var><t2ype>(s2vs)
      ) where
      {
        implement
        list_map$fopr<s2var><t2ype>(s2v) =
        t2ype_srt_xtv(s2v.sort(), t2xtv_new(loc0))
      }
      val t2p2 =
      t2ype_substs
      (t2p2, s2vs, $UN.list_vt2t(tsub))
      val ((*void*)) = list_vt_free(tsub)
    }
  | _ (* non-quantifier *) => auxtp1(t2p1, t2p2)
  )
//
)
and
auxtp1
( t2p1: t2ype
, t2p2: t2ype): bool =
(
case+
t2p1.node() of
| T2Pbas(nam1) =>
  (
  case+
  t2p2.node() of
  | T2Pbas(nam2) =>
    (nam1 = nam2)
  | _ (* else *) => false
  )
| T2Pcst(s2c1) =>
  (
  case+
  t2p2.node() of
  | T2Pcst(s2c2) =>
    (s2c1 = s2c2)
  | _ (* else *) => false
  )
| T2Pvar(s2v1) =>
  (
  case+
  t2p2.node() of
  | T2Pvar(s2v2) =>
    (s2v1 = s2v2)
  | _ (* else *) => false
  )
| T2Papp(t2f1, arg1) =>
  (
  case+
  t2p2.node() of
  | T2Papp(t2f2, arg2) =>
    let
      val tfun =
      unify(loc0, t2f1, t2f2) 
      val targ =
      unify(loc0, arg1, arg2)
    in
      if tfun then targ else false
    end
  | _ (* non-T2Papp *) => false
  )
//
| T2Pfc2(fc1) =>
  (
  case+
  t2p2.node() of
  | T2Pfc2(fc2) =>
    funclo2_equal(fc1, fc2)
  | _(*non-T2Pfc2*) => false
  )
| T2Pfun
  (tfc1, npf1, arg1, res1) =>
  (
  case+
  t2p2.node() of
  | T2Pfun
    (tfc2, npf2, arg2, res2) =>
    let
      val
      tnpf = (npf1 = npf2)
      val
      tfcr = unify(loc0, tfc1, tfc2)
      val
      targ = unify(loc0, arg2, arg1)
      val
      tres = unify(loc0, res1, res2)
    in
      (tnpf && (tfcr && (targ && tres)))
    end
  | _ (* else *) => false
  )
//
| T2Ptyext
  (tnm1, tps1) =>
  (
  case+
  t2p2.node() of
  | T2Ptyext(tnm2, tps2) =>
    if
    (tnm1 = tnm2)
    then
    unify(loc0, tps1, tps2) else false
  | _ (* non-T2Ptyext *) => false
  )
//
| T2Ptyrec
  (knd1, npf1, lxs1) =>
  (
  case+
  t2p2.node() of
  | T2Ptyrec(knd2, npf2, lxs2) =>
    (
      tknd && (tnpf && tlxs)
    ) where
    {
      val tknd = (knd1 = knd2)
      val tnpf = (npf1 = npf2)
      val tlxs = unify(loc0, lxs1, lxs2)
    }
  | _ (* non-T2Ptyrec *) => false
  )
//
| T2Pnone0() =>
  (
  case+ t2p2.node() of T2Pnone0() => true | _ => false
  )
//
| _ (* else *) => false
)
//
fun
auxtv1
( xtv1: t2xtv
, t2p2: t2ype): bool =
(
case+
t2p2.node() of
| T2Pxtv(xtv2) => true where
  {
    val () =
    if xtv1 = xtv2
      then () else xtv1.type(t2p2)
    // end of [if]
  }
| _ (* else *) =>
  let
    val occurs =
    t2xtv_occurs(xtv1, t2p2) 
(*
    val ((*void*)) =
    println!
    ("auxtv1: occurs = ", occurs)
*)
in
    if occurs then false else
    let
      val () = xtv1.type(t2p2) in true
    end
  end
)
//
fun
auxtv2
( t2p1: t2ype
, xtv2: t2xtv): bool =
  let
    val occurs =
    t2xtv_occurs(xtv2, t2p1) 
(*
    val ((*void*)) =
    println!
    ("auxtv2: occurs = ", occurs)
*)
  in
    if occurs then false else
    let
      val () = xtv2.type(t2p1) in true
    end
  end
//
} (* end of [where] *)
) (* end of [unify_t2ype_t2ype] *)

(* ****** ****** *)

implement
unify_t2ypelst_t2ypelst
  (loc0, t2ps1, t2ps2) =
(
case+ t2ps1 of
| list_nil() =>
  (
  case+ t2ps2 of
  | list_nil() => true
  | list_cons _ => false
  )
| list_cons(t2p1, t2ps1) =>
  (
  case+ t2ps2 of
  | list_nil() => false
  | list_cons(t2p2, t2ps2) =>
    let
      val
      test1 =
      unify(loc0, t2p1, t2p2)
      val
      test2 =
      unify(loc0, t2ps1, t2ps2)
    in
      if test1 then test2 else false
    end
  )
) (* end of [unify_t2ypelst_t2ypelst] *)

(* ****** ****** *)

implement
unify_labt2ype_labt2ype
(loc0, lt2p1, lt2p2) =
let
val+TLABELED(l1, t2p1) = lt2p1
val+TLABELED(l2, t2p2) = lt2p2
in
//
if
(l1 = l2)
then unify(loc0, t2p1, t2p2) else false
//
end // end of [unify_labt2ype_labt2ype]

(* ****** ****** *)

implement
unify_labt2ypelst_labt2ypelst
(loc0, ltps1, ltps2) =
(
case+ ltps1 of
| list_nil() =>
  (
  case+ ltps2 of
  | list_nil() => true
  | list_cons _ => false
  )
| list_cons(lt2p1, ltps1) =>
  (
  case+ ltps2 of
  | list_nil() => false
  | list_cons(lt2p2, ltps2) =>
    let
      val
      test1 =
      unify(loc0, lt2p1, lt2p2)
      val
      test2 =
      unify(loc0, ltps1, ltps2)
    in
      if test1 then test2 else false
    end
  )
) (* end of [unify_labt2ypelst_labt2ypelst] *)

(* ****** ****** *)

implement
d3pat_dn
(d3p0, t2p0) = let
//
(*
val () =
println!
("d3pat_dn: d3p0 = ", d3p0)
val () =
println!
("d3pat_dn: t2p0 = ", t2p0)
*)
//
val loc0 = d3p0.loc()
val test =
unify(loc0, d3p0.type(), t2p0)
//
(*
val () =
println!
("d3pat_dn: test = ", test)
*)
//
in
//
if test then d3p0 else d3pat_cast(d3p0, t2p0)
//
end // end of [d3pat_dn]

(* ****** ****** *)

implement
d3pat_dapp_up
( loc0
, d3f0, npf0, d3ps) =
let
//
val
targ =
d3patlst_get_type(d3ps)
//
val tres = t2ype_new(loc0)
//
// HX: d2con.type()
val tfun = // is FC2fun!
t2ype_fun0(loc0, npf0, targ, tres)
//
val d3f0 = d3pat_dn(d3f0, tfun)
//
in
//
d3pat_make_node
(loc0, tres, D3Pdapp(d3f0, npf0, d3ps))
//
end // end of [d3pat_dapp_up]

(* ****** ****** *)

implement
d3pat_tuple_up
( loc0
, knd1, npf2, d3ps) = let
//
val
tknd =
(
ifcase
| knd1 = 0 => TYRECflt0(*void*)
| _(*else*) => TYRECbox0(*void*)
) : tyrec // end of [val]
//
val
ltps =
(
  auxlst(d3ps, 0(*i0*))
) where
{
fun
auxlst
( d3ps
: d3patlst
, i0: int): labt2ypelst =
(
case+ d3ps of
| list_nil() =>
  list_nil((*void*))
| list_cons(d3p0, d3ps) =>
  let
    val l0 =
    label_make_int(i0)
    val lt2p0 =
    TLABELED(l0, d3p0.type())
  in
    list_cons(lt2p0, auxlst(d3ps, i0+1))
  end // end of [list_cons]
)
} (* end of [val] *)
//
val s2t0 =
  the_sort2_none
val t2p0 =
  t2ype_tyrec(s2t0, tknd, npf2, ltps)
//
in
  d3pat_make_node
  (loc0, t2p0, D3Ptuple(knd1, npf2, d3ps))
end (* end of [d3pat_tuple_up] *)

(* ****** ****** *)

implement
d3exp_dn
(d3e0, t2p0) = let
//
val
test =
unify
(d3e0.loc(), d3e0.type(), t2p0)
//
in
//
if
test
then d3e0 else d3exp_cast(d3e0, t2p0)
//
end // end of [d3exp_dn]

(* ****** ****** *)

implement
d3explst_dn
(loc0, d3es, t2ps) = let
//
fun
auxt2ps
( t2ps
: t2ypelst
)
: d3explst =
(
case+ t2ps of
| list_nil() =>
  list_nil()
| list_cons(t2p0, t2ps) =>
  let
    val d3e0 =
    d3exp_none0_1(loc0, t2p0)
  in
    list_cons(d3e0, auxt2ps(t2ps))
  end
)
fun
auxd3es
( d3es
: d3explst
)
: d3explst =
(
case+ d3es of
| list_nil() =>
  list_nil()
| list_cons(d3e0, d3es) =>
  let
    val d3e0 =
    d3exp_none2_0(d3e0)
  in
    list_cons(d3e0, auxd3es(d3es))
  end
)
//
in (* in-of-let *)
//
case+ d3es of
| list_nil() => auxt2ps(t2ps)
| list_cons _ =>
  (
  case+ t2ps of
  | list_nil() => auxd3es(d3es)
  | list_cons _ =>
    let
      val+
      list_cons
      (d3e0, d3es) = d3es
      val+
      list_cons
      (t2p0, t2ps) = t2ps
      val
      d3e0 = d3exp_dn(d3e0, t2p0)
    in
      list_cons(d3e0, auxd3es(d3es))
    end
  )
//
end (* end of [d3explst_dn] *)

(* ****** ****** *)

implement
d3exp_sapp_up
( loc0
, d3f0, s2es ) = let
//
fun
auxmain
( t2p0
: t2ype): d3exp = let
//
val t2p0 = hnfize(t2p0)
//
in
//
if
auxtest(s2es)
then
(
case+
t2p0.node() of
| T2Puni
  (s2vs, t2p1) =>
  let
//
  val tsub =
  auxtsub(s2vs, s2es)
  val t2p1 =
  (
  t2ype_substs
  (t2p1, s2vs, tsub)
  ) where
  {
    val
    tsub =
    $UN.list_vt2t(tsub)
  }
  val () = list_vt_free(tsub)
//
  in
    d3exp_make_node
    (loc0, t2p1, D3Esap1(d3f0, s2es))
  end
//
| T2Pexi
  (s2vs, t2p1) => auxmain(t2p1)
//
| _(*non-T2Puni*) =>
  d3exp_make_node
    (loc0, t2p0, D3Esap0(d3f0, s2es))
  // d3exp_make_node
) (* end of [then] *)
else
(
  d3exp_make_node
    (loc0, t2p0, D3Esap0(d3f0, s2es))
  // d3exp_make_node
) (* end of [else] *)
end where
{
fun
auxtest
( s2es
: s2explst): bool =
(
case+ s2es of
| list_nil() => false
| list_cons(s2e0, s2es) =>
  let
    val
    s2t0 = s2e0.sort()
  in
    if
    sort2_is_impred(s2t0)
    then true else auxtest(s2es)
  end
)
fun
auxtsub
( s2vs
: s2varlst
, s2es
: s2explst)
: List0_vt(t2ype) =
(
case+ s2vs of
| list_nil
  ((*void*)) =>
  list_vt_nil()
| list_cons
  (s2v0, s2vs) =>
  (
    case+ s2es of
    | list_nil() =>
      let
      val
      t2p0 = the_t2ype_none0
      in
        list_vt_cons
        (t2p0, auxtsub(s2vs, s2es))
      end
    | list_cons
      (s2e0, s2es1) =>
      (
      case+
      s2e0.node() of
      | S2Eany(k0) =>
        let
          val s2t0 =
          s2v0.sort()
          val t2p0 =
          t2ype_srt_xtv
          (s2t0, t2xtv_new(loc0))
        in
          if
          (k0 >= 2)
          then
          list_vt_cons
          (t2p0, auxtsub(s2vs, s2es))
          else
          list_vt_cons
          (t2p0, auxtsub(s2vs, s2es1))
        end
      | _(*non-S2Eany*) =>
        let
          val t2p0 = s2exp_erase(s2e0)
        in
          list_vt_cons(t2p0, auxtsub(s2vs, s2es))
        end
      )
  )
) (* end of [auxtsub] *)
} // where // end of [auxmain]
//
in
  auxmain(d3f0.type((*void*)))
end (* end of [d3exp_sapp_up] *)

(* ****** ****** *)
//
local
//
fun
auxtcst
( d2f0
: d2exp
)
: d2cstopt_vt =
(
case+
d2f0.node() of
| D2Ecst1
  (d2c0) => Some_vt(d2c0)
| D2Etapp
  (d2f0, _) => auxtcst(d2f0)
| _ (*else*) => None_vt(*void*)
)
//
fun
auxtarg
( d2f0
: d2exp
, ti2s
: ti2arglst
)
: ti2arglst =
(
case+
d2f0.node() of
| D2Etapp
  (d2f0, s2es) =>
  (
    auxtarg(d2f0, t2is)
  ) where
  {
  val ti2a =
  ti2arg_make(d2f0.loc(), s2es)
  val t2is = list_cons(ti2a, ti2s)
  }
| _ (* non-D2Etapp *) => ti2s
)
//
fun
auxd2f0
( d2f0
: d2exp
, sess
: List0_vt(s2explst)
)
: List0_vt(s2explst) =
(
case+
d2f0.node() of
| D2Etapp
  (d2f0, s2es) =>
  (
  auxd2f0(d2f0, sess)
  ) where
  {
  val sess =
  list_vt_cons(s2es, sess)
  }
| _(*non-D2Etapp*) => sess
)
//
fun
auxtq2a
( loc0
: loc_t
, tq2a
: tq2arg
, s2es
: s2explst
, tsub
: t2ypelst_vt
)
: t2ypelst_vt =
(
auxs2vs(loc0, tq2a.s2vs(), s2es, tsub)
)
and
auxs2vs
( loc0
: loc_t
, s2vs
: s2varlst
, s2es
: s2explst
, tsub
: t2ypelst_vt
)
: t2ypelst_vt =
(
case+ s2vs of
| list_nil() => tsub
| list_cons
  (s2v0, s2vs) =>
  (
  case+ s2es of
  | list_nil() =>
    let
    val s2t0 =
    s2v0.sort()
    val t2p0 =
    t2ype_srt_xtv
    (s2t0, t2xtv_new(loc0))
    val tsub =
    list_vt_cons(t2p0, tsub)
    in
      auxs2vs(loc0, s2vs, s2es, tsub)
    end
  | list_cons(s2e0, s2es1) =>
    ( case+
      s2e0.node() of
      | S2Eany(k0) =>
        let
          val s2t0 =
          s2v0.sort()
          val t2p0 =
          t2ype_srt_xtv
          (s2t0, t2xtv_new(loc0))
          val tsub =
          list_vt_cons(t2p0, tsub)
        in
          if
          (k0 >= 2)
          then
          auxs2vs(loc0, s2vs, s2es, tsub)
          else
          auxs2vs(loc0, s2vs, s2es1, tsub)
        end
      | _(*non-S2Eany*) =>
        let
          val t2p0 =
          s2exp_erase(s2e0)
          val tsub =
          list_vt_cons(t2p0, tsub)
        in
          auxs2vs(loc0, s2vs, s2es1, tsub)
        end
    )
  )
) (* end of [auxs2vs] *)
//
fun
auxtqas
( loc0
: loc_t
, tqas
: tq2arglst
, sess
: List0_vt
  (s2explst)
, tsub
: t2ypelst_vt
)
: t2ypelst_vt =
(
case+ tqas of
| list_nil
  ((*void*)) =>
  let
  val () =
  list_vt_free(sess) in tsub
  end
| list_cons
  (tq2a, tqas) =>
  (
  case+ sess of
  |
  ~list_vt_nil() =>
   let
   val s2es = list_nil()
   val sess = list_vt_nil()
   val tsub =
   auxtq2a(loc0, tq2a, s2es, tsub)
   in
     auxtqas(loc0, tqas, sess, tsub)
   end
  |
  ~list_vt_cons(s2es, sess) =>
   let
     val tsub =
     auxtq2a(loc0, tq2a, s2es, tsub)
   in
     auxtqas(loc0, tqas, sess, tsub)
   end
   )
) (* end of [auxtqas] *)
//
in (* in-of-local *)

implement
d3exp_tapp_up
( loc0
, d2f0, s2es ) =
let
val
opt = auxtcst(d2f0)
in
//
case+ opt of
|
~None_vt() =>
(
d3exp_make_node
(loc0, t2p0, D3Etapp(d2f0, s2es))
) where
{
  val t2p0 = t2ype_new(d2f0.loc())
}
|
~Some_vt(d2c0) =>
let
//
val ti2a =
ti2arg_make(loc0, s2es)
val ti2s =
auxtarg
(d2f0, list_sing(ti2a))
//
val tqas = d2c0.tqas()
val sess = list_vt_sing(s2es)
val sess = auxd2f0(d2f0, sess)
//
val tsub = list_vt_nil()
val tsub =
auxtqas(loc0, tqas, sess, tsub)
val tsub =
list_vt2t(list_vt_reverse(tsub))
//
val s2vs = d2cst_get_s2vs(d2c0)
val t2p0 =
t2ype_substs(d2c0.type(), s2vs, tsub)
//
in
d3exp_make_node
( loc0, t2p0
, D3Etcst(d2c0, ti2s, TI3ARGsome(tsub)))
end
//
end // end of [d3exp_tapp_up]
//
end // end of [local]
//
(* ****** ****** *)

implement
d3exp_dapp_up
( loc0
, d3f0, npf0, d3es) =
let
//
val
targ =
d3explst_get_type(d3es)
//
val tres = t2ype_new(loc0)
//
// HX: FC2cloref is
val tfun = // the default
t2ype_fun0(loc0, npf0, targ, tres)
//
val d3f0 = d3exp_dn(d3f0, tfun)
//
in
//
d3exp_make_node
(loc0, tres, D3Edapp(d3f0, npf0, d3es))
//
end // end of [d3exp_dapp_up]

(* ****** ****** *)
//
implement
d3exp_seqn_up
(loc0, d3es, d3e2) =
d3exp_make_node
(loc0, d3e2.type(), D3Eseqn(d3es, d3e2))
//
(* ****** ****** *)

implement
d3exp_tuple_up
( loc0
, knd1, npf2, d3es) = let
//
val
tknd =
(
ifcase
| knd1 = 0 => TYRECflt0(*void*)
| _(*else*) => TYRECbox0(*void*)
) : tyrec // end of [val]
//
val
ltps =
(
  auxlst(d3es, 0(*i0*))
) where
{
fun
auxlst
( d3es
: d3explst
, i0: int): labt2ypelst =
(
case+ d3es of
| list_nil() =>
  list_nil((*void*))
| list_cons(d3e0, d3es) =>
  let
    val l0 =
    label_make_int(i0)
    val lt2p0 =
    TLABELED(l0, d3e0.type())
  in
    list_cons(lt2p0, auxlst(d3es, i0+1))
  end // end of [list_cons]
)
} (* end of [val] *)
//
val s2t0 =
  the_sort2_none
val t2p0 =
  t2ype_tyrec(s2t0, tknd, npf2, ltps)
//
in
  d3exp_make_node
  (loc0, t2p0, D3Etuple(knd1, npf2, d3es))
end (* end of [d3exp_tuple_up] *)

(* ****** ****** *)

implement
d3exp_dtsel_up
( loc0
, lab, dpis, arg3) =
let
  val t2p0 = t2ype_new(loc0)
in
  d3exp_make_node
  (loc0, t2p0, D3Edtsel(lab, dpis, arg3))
end // end of [d3exp_dtsel_up]

(* ****** ****** *)

implement
d3exp_if0_up
( loc0
, d3e1, d3e2, opt3) =
let
//
val d3e1 =
d3exp_dn
(d3e1, the_t2ype_bool)
val tres =
(
case+ opt3 of
| None _ => the_t2ype_void
| Some _ => t2ype_new(loc0)
) : t2ype // end of [val]
//
val d3e2 =
d3exp_dn(d3e2, tres)
val opt3 =
(
case+ opt3 of
| None() => None()
| Some(d3e3) =>
  Some(d3exp_dn(d3e3, tres))
) : d3expopt // end of [val]
//
in
  d3exp_make_node
  (loc0, tres, D3Eif0(d3e1, d3e2, opt3))
end // end of [d3exp_if0_up]

(* ****** ****** *)

implement
d3exp_let_up
(
  loc0, d3cs, d3e2
) = let
//
val
t2p0 = d3e2.type((*void*))
//
in
d3exp_make_node(loc0, t2p0, D3Elet(d3cs, d3e2))
end // end of [d3exp_let_up]

(* ****** ****** *)

implement
d3exp_where_up
(loc0, d3e1, d3cs) =
let
val t2p1 = d3e1.type()
in
d3exp_make_node(loc0, t2p1, D3Ewhere(d3e1, d3cs))
end // end of [d3exp_where_up]

(* ****** ****** *)

implement
d3exp_lam_up
( loc0
, f3as
, res0, arrw, body) =
let
//
val
tfun = let
val
tfc2 =
(
  auxtfc2(arrw)
) where
{
fun
auxtfc2
( arrw
: f1unarrow
) : t2ype =
(
case arrw of
| F1UNARROWdflt
  () =>
  t2ype_new(loc0)
| F1UNARROWlist
  (s1es) =>
  (
    t2ype_fc2(fc2)
  ) where
  {
    val lin =
    s1explst_get_lin(s1es)
    val fc2 =
    s1explst_get_fc2(s1es)
//
    val fc2 =
    (
    if
    lin = 0
    then fc2 else funclo2_linize(fc2)
    ) : funclo2
  }
)
}
fun
auxfa3g
( fa3g
: f3arglst
, tres
: t2ype
, flag: int): t2ype =
(
case+ fa3g of
| list_nil() => tres
| list_cons(x0, xs) =>
  (
  case-
  x0.node() of
  | F3ARGsome_dyn
    (npf, d3ps) =>
    let
    val tfc2 =
    ( if
      flag = 0
      then tfc2
      else
      t2ype_fc2(FC2cloref)
    ) : t2ype // end-of-val
    val t2ps =
    d3patlst_get_type(d3ps)
    val tres =
    auxfa3g(xs, tres, flag+1)
    in
    t2ype_fun1(tfc2, npf, t2ps, tres)
    end
  | F3ARGsome_sta
    (s2vs, s2ps) =>
    let
    val
    tres =
    auxfa3g
    (xs, tres, flag) in t2ype_uni(s2vs, tres)
    end
  | F3ARGsome_met(s2es) => auxfa3g(xs, tres, flag)
  )
)
in
  auxfa3g(f3as, body.type(), 0)
end // end-of-val
//
(*
val () =
println!("d3exp_lam_up: f3as = ", f3as)
val () =
println!("d3exp_lam_up: tfun = ", body)
val () =
println!("d3exp_lam_up: f3as = ", f3as)
*)
//
in
d3exp_make_node
(loc0, tfun, D3Elam(f3as, res0, arrw, body))
end // end of [d3exp_lam_up]

(* ****** ****** *)

implement
d2cst_ti2as_ti3a
(loc0, d2c0, tias) =
(
auxtias_0(d2c0, tias)
) where
{
//
fun
auxtias_0
( d2c0
: d2cst
, tias
: ti2arglst): ti3arg =
let
(*
val () =
println!
("auxtias_0: d2c0 = ", d2c0)
val () =
println!
("auxtias_0: tias = ", tias)
*)
in
let
  val tqas = d2c0.tqas()
  val t2ps = list_vt_nil()
in
  auxtias_1(tqas, tias, t2ps)
end
end
and
auxtias_1
( tqas
: tq2arglst
, tias
: ti2arglst
, t2ps
: List0_vt(t2ype)): ti3arg =
let
(*
val () =
println!
("auxtias_1: tqas = ", tqas)
*)
in
case+ tqas of
| list_nil() =>
  (
    TI3ARGsome(t2ps)
  ) where
  {
    val t2ps =
    list_vt2t
    (list_vt_reverse(t2ps))
  }
| list_cons(tq2a, tqas) =>
  let
    val
    s2vs = tq2a.s2vs()
  in
    case+ tias of
    | list_nil() => let
      val
      s2es = list_nil()
      val
      t2ps =
      auxtias_2(s2vs, s2es, t2ps)
      in
        auxtias_1(tqas, tias, t2ps)
      end
    | list_cons
      (ti20, tias) => let
      val
      s2es = ti20.s2es()
      val
      t2ps =
      auxtias_2(s2vs, s2es, t2ps)
      in
        auxtias_1(tqas, tias, t2ps)
      end
  end
end
and
auxtias_2
( s2vs
: s2varlst 
, s2es
: s2explst
, t2ps
: List0_vt(t2ype)
)
: List0_vt(t2ype) =
(
case+ s2vs of
| list_nil() => t2ps
| list_cons
  (s2v0, s2vs) =>
  (
  case+ s2es of
  | list_nil() => let
    val s2t0 =
    s2v0.sort()
    val t2p0 =
    t2ype_srt_xtv
    (s2t0, t2xtv_new(loc0))
    val
    t2ps =
    list_vt_cons(t2p0, t2ps)
    in
      auxtias_2(s2vs, s2es, t2ps)
    end
  | list_cons
    (s2e0, s2es1) =>
    ( case+
      s2e0.node() of
      | S2Eany(k0) =>
        let
          val s2t0 =
          s2v0.sort()
          val t2p0 =
          t2ype_srt_xtv
          (s2t0, t2xtv_new(loc0))
          val t2ps =
          list_vt_cons(t2p0, t2ps)
        in
          if
          (k0 >= 2)
          then
          auxtias_2(s2vs, s2es, t2ps)
          else
          auxtias_2(s2vs, s2es1, t2ps)
        end
      | _(*non-S2Eany*) =>
        let
          val t2p0 =
          s2exp_erase(s2e0)
          val t2ps =
          list_vt_cons(t2p0, t2ps)
        in
          auxtias_2(s2vs, s2es1, t2ps)
        end
    )
  )
) (* end of [auxtias_2] *)
//
} (* end of [d2cst_ti2as_ti3a] *)

(* ****** ****** *)

implement
t2ype_f2arg_elim
(
loc0, tfun, f2as
) =
(
( f3as, tfun ) where
{
  var tfun = tfun
  val f3as = auxf2as_0(f2as, tfun)
}
) where
{
fun
auxf2as_0
( f2as
: f2arglst
, tfun
: &t2ype >> _
)
: f3arglst =
(
case+ f2as of
| list_nil() =>
  list_nil()
| list_cons
  (f2a0, f2as) =>
  (
    list_cons(f3a0, f3as)
  ) where
  {
    val
    f3a0 = auxf2as_1(f2a0, tfun)
    val
    f3as = auxf2as_0(f2as, tfun)
  }
) (* auxf2as_0 *)
and
auxf2as_1
( f2a0
: f2arg
, tfun
: &t2ype >> _): f3arg =
(
let
val () =
println!("auxf2as_1: f2a0 = ", f2a0)
val () =
println!("auxf2as_1: tfun = ", tfun)
in
case-
f2a0.node() of
(*
| F2ARGnone _ => ...
*)
| F2ARGsome_met _ => auxf2as_1m(f2a0, tfun)
| F2ARGsome_sta _ => auxf2as_1s(f2a0, tfun)
| F2ARGsome_dyn _ => auxf2as_1d(f2a0, tfun)
end
)
//
and
auxf2as_1m
( f2a0
: f2arg
, tfun
: &t2ype >> _): f3arg =
let
//
val-
F2ARGsome_met
( s2es ) = f2a0.node()
//
in
  f3arg_make_node
  (f2a0.loc(), F3ARGsome_met(s2es))
end
and
auxf2as_1s
( f2a0
: f2arg
, tfun
: &t2ype >> _): f3arg =
let
//
val-
F2ARGsome_sta
( svs1
, s2ps ) = f2a0.node()
//
val
loc0 = f2a0.loc()
val
t2p0 = t2ype_hnfize(tfun)
//
in
//
if
auxtest(svs1)
then
(
case+
t2p0.node() of
|
T2Puni
(svs2, t2p0) =>
let
val tsub =
auxtsub(svs2, svs1)
val t2p0 =
(
t2ype_revars
  (t2p0, svs2, tsub)
// t2ype_revars
) where
{
val
tsub = $UN.list_vt2t(tsub)
} (* where *) // end-of-val
val () = list_vt_free(tsub)
in
  let
  val () = tfun := t2p0
  in
  f3arg_make_node
  ( loc0
  , F3ARGsome_sta(svs1, s2ps))
  end
end
| _(*non-T2Puni*) =>
  let
  val () = tfun := t2p0
  in
    f3arg_make_node
      (loc0, F3ARGnone2(f2a0))
    // f3arg_make_node
  end
) (* end of [then] *)
else
let
val () = tfun := t2p0
in
  f3arg_make_node
  (loc0, F3ARGsome_sta(svs1, s2ps))
end // let // end of [else]
//
end where
{
fun
auxtest
( s2vs
: s2varlst): bool =
(
case+ s2vs of
| list_nil() => false
| list_cons(s2v0, s2vs) =>
  let
  val s2t0 = s2v0.sort()
  in
    if
    sort2_is_impred(s2t0)
    then true else auxtest(s2vs)
  end
)
fun
auxtsub
( xs0: s2varlst
, ys0: s2varlst
) : List0_vt(s2var) =
(
case+ xs0 of
| list_nil _ =>
  list_vt_nil()
| list_cons(x0, xs1) =>
  (
  case+ ys0 of
  | list_nil() =>
    list_vt_cons(x0, auxtsub(xs1, list_nil()))
  | list_cons(y0, ys1) =>
    let
    val st = y0.sort()
    in
    if
    sort2_is_impred(st)
    then list_vt_cons(y0, auxtsub(xs1, ys1)) else auxtsub(xs0, ys1)
    end
  )
) (* end of [auxtsub] *)
} // end of [let] // end of [auxf2as_1s]
//
and
auxf2as_1d
( f2a0
: f2arg
, tfun
: &t2ype >> _): f3arg =
let
//
val-
F2ARGsome_dyn
( npf1
, d2ps) = f2a0.node()
//
val
loc0 = f2a0.loc()
val
t2p0 = t2ype_hnfize(tfun)
//
in
//
case+
t2p0.node() of
//
| T2Puni
  (s2vs, t2p0) =>
  (
    tfun := t2p0;
    auxf2as_1d(f2a0, tfun)
  ) where
  {
    val t2p0 =
    t2ype_renams(t2p0, s2vs)
  }
| T2Pfun
  (_, _, t2ps, t2p0) =>
  let
    val d3ps =
    trans23_dpatlst_dn(d2ps, t2ps)
  in
    tfun := t2p0;
    f3arg_make_node
    (loc0, F3ARGsome_dyn(npf1, d3ps))
   end
//
| _(*non-T2Puni/fun*) =>
  f3arg_make_node(loc0, F3ARGnone2(f2a0))
//
end // end of [let] // end of [auxf2as_1d]
//
} (* end of [t2ype_f3arg_elim] *)
//
(* ****** ****** *)

(* end of [trans23_util0.dats] *)
