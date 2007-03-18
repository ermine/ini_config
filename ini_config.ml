(*
 * (c) 2005-2007 Anastasia Gornostaeva. <ermine@ermine.pp.ru>
 *)

type ini = (string * (string * string) list) list

exception IniError of int

let getvalue ini section key =
   List.assoc key (List.assoc section ini)

let parse file =
   let f = open_in file in
   let lexbuf = Lexing.from_channel f in
   let ini = 
      try
	 Ini_parser.config_file Ini_lexer.token lexbuf
      with 
	 | Parsing.Parse_error 
	 | Failure "lexing: empty token" ->
	      close_in f;
	      raise (IniError lexbuf.Lexing.lex_curr_p.Lexing.pos_lnum)
   in
      close_in f;
      ini

