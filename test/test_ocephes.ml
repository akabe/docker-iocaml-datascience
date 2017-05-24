(** Tests for Ocephes *)

#require "iocaml-kernel" ;;
#require "ocephes" ;;

let () =
  assert(abs_float (Ocephes.gamma (-1.5) -. 2.36327) < 1e-4) ;
  assert(abs_float (Ocephes.gamma 3.0 -. 2.0) < 1e-4) ;
  assert(abs_float (Ocephes.gamma 4.0 -. 6.0) < 1e-4)
;;
