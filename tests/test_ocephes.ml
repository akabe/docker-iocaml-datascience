(** Tests for Ocephes *)

#require "iocaml-kernel" ;;
#require "ocephes" ;;

let () =
  Format.printf "gamma = %g@." (Ocephes.gamma 4.0)
;;
