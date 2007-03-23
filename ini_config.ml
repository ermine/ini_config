(*
 * (c) 2005-2007 Anastasia Gornostaeva. <ermine@ermine.pp.ru>
 *)

type ini = (string * (string * string) list) list

exception IniError of int

let get_value ini section key =
   List.assoc key (List.assoc section ini)

let get_value_list ini section key =
   let v = get_value ini section key in
      Str.split (Str.regexp "[' ' '\t']*,[' ' '\t']*") v

let get_value_option ini section key =
   try let v = get_value ini section key in
      if v = "" then None else Some v
   with Not_found -> None

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

