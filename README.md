# `ppx_cps`

`ppx_cps` is a very simple OCaml PPX that rewrites let-bindings into CPS style.

```ocaml
let%cps x = f in e
(* ==> *)
f (fun x -> e)
```

## Setup

```sh
$ git clone <url>/ppx_cps.git
$ opam pin add ppx_cps ppx_cps/
```
