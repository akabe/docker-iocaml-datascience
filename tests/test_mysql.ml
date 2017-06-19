(** Tests for MySQL *)

#require "mysql" ;;

let () =
  let c = Mysql.quick_connect
            ~host:"mysql" ~port:3306
            ~user:"root" ~password:"" () in
  Mysql.disconnect c
;;
