(** Tests for mariadb *)

#require "iocaml-kernel" ;;
#require "mariadb" ;;

open Printf ;;
module M = Mariadb.Blocking ;;

let or_die = function
  | Ok x -> x
  | Error (num, msg) -> failwith (sprintf "error #%d: %s" num msg)
;;

let () =
  let mariadb = M.connect ~host:"127.0.0.1" ~user:"root" ~pass:"" () |> or_die in
  M.close mariadb
;;
