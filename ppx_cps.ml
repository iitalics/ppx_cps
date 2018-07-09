open Ppxlib

let transform ~loc vb body =
  Ast_helper.(
    Exp.apply ~loc
      vb.pvb_expr
      [ Nolabel,
        Exp.fun_ ~loc:vb.pvb_loc
          Nolabel None
          vb.pvb_pat
          body ])

let extension =
  let module P = Ast_pattern in
  let open Extension in
  declare "cps"
    Context.expression
    P.(pstr (pstr_eval
               (pexp_let nonrecursive (__ ^:: nil) __)
               __ ^:: nil))
    (fun ~loc ~path vb eb _ ->
      transform ~loc vb eb)

let () =
  Driver.register_transformation "ppx_cps"
    ~extensions:[ extension ]
