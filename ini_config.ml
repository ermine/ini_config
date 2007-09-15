(*
 * (c) 2005-2007 Anastasia Gornostaeva. <ermine@ermine.pp.ru>
 *)

type ini = (string * (string * string) list) list

exception IniError of int

let get_section ini section =
   List.assoc section ini

let get_value ini section key =
   List.assoc key (List.assoc section ini)

let split str =
   let rec rskip_ws i j =
      if j >= 0 then
	 if str.[i+j] = ' ' || str.[j] = '\t' then
	    rskip_ws i (j-1)
	 else
	    j
      else
	 j
   in
   let rec lskip_ws i =
      if i < String.length str then
	 if str.[i] = ' ' || str.[i] = '\t' then
	    lskip_ws (i+1)
	 else
	    i
      else
	 i
   in
   let rec aux_split acc i j =
      if i+j < String.length str then
	 if str.[i+j] = ',' then
	    let k = rskip_ws i (j-1) in
	    let piece = String.sub str i (k+1) in
	    let newi = lskip_ws (i+j+1) in
	       aux_split (piece :: acc) newi 0
	 else
	    aux_split acc i (j+1)
      else
	 List.rev acc
   in
      aux_split [] 0 0

let get_value_list ini section key =
   let v = get_value ini section key in
      split v

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

