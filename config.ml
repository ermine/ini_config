(*                                                                          *)
(* (c) 2005 Anastasia Gornostaeva. <ermine@ermine.pp.ru>                    *)
(*                                                                          *)

let parse file =
   let f = open_in file in
   let lexbuf = Lexing.from_channel f in
      try
         Config_parser.config Config_lexer.token lexbuf
      with exn ->
	 Printf.printf "%s\n" 
	    (Printexc.to_string exn);
	 raise exn

(*
let _ =
   let cfg = parse "greybottle.conf" in
      List.iter (fun (a,b) -> Printf.printf "%s =  %s\n" a 
		    (String.concat ", " b)) cfg
*)
