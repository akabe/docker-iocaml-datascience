(** Plot graphs by Archimedes on IOCaml *)

#require "iocaml-kernel" ;;
#require "archimedes.cairo" ;;

(** User-defined Archimedes backend for IOCaml *)
module Archimedes_iocaml = Archimedes.Backend.Register(struct
    include Archimedes_cairo.B

    let name = "iocaml"

    let close ~options b =
      let ctx : Cairo.context = Obj.magic b in
      let surf = Cairo.get_target ctx in
      Cairo.PNG.write_to_stream ~output:(output_string Iocaml.mime) surf ;
      close ~options b ;
      Iocaml.send_mime ~base64:true "image/png"
  end)
