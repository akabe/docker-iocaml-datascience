(** Tests for postgresql *)

#thread ;; (* for Mutex *)
#require "postgresql" ;;

open Postgresql ;;

let () =
  let c = new connection
              ~host:"postgres" ~port:"5432"
              ~user:"postgres" ~password:"" () in
  c#finish
;;
