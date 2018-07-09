open OUnit2

let depth = ref 0

let call_deeper f =
  let d = !depth in
  depth := d + 1 ;
  f () ;
  depth := d

let map' l f = List.map f l

(***********************************************************)

open OUnit2

let assert_int_equal ~ctxt i j =
  assert_equal ~ctxt ~cmp:(=) ~printer:string_of_int
    i j

;;

test_list
  [ "test let%cps unit" >::
      (fun ctxt ->
        let d0 = !depth in
        begin
          let%cps () = call_deeper in
          assert_int_equal ~ctxt (d0 + 1) !depth ;
        end ;
        assert_int_equal ~ctxt d0 !depth)

  ; "test let%cps elem" >::
      (fun ctxt ->
        assert_equal ~ctxt
          [ 5; 10; 15 ]
          (let%cps x = map' [ 1; 2; 3 ] in x * 5))
  ]
|> run_test_tt_main
