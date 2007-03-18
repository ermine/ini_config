{
(*
 * (c) 2005-2007 Anastasia Gornostaeva. <ermine@ermine.pp.ru>
 *)

open Ini_parser
}

let space = [' ' '\t']
let eol = space* ('#' [^ '\n']*)? '\r'? '\n'

(* almost as XML tag *)
let ident = ['a'-'z' 'A'-'Z' '_' ':'] ['a'-'z' 'A'-'Z' '0'-'9' '.' '-' '_' ':']*


rule token = parse
   | '[' (ident as ident) ']'
	 { Section ident }
   | (ident as ident) space* '=' space*
	 { let value = value [] lexbuf in
	      KeyValue (ident, value) }
   | eol+
	 { EOL }
   | eof
	 { EOF }

and value acc = parse
   | ([^  '#' '\n']* as str) eol+ space+ 
	 { value (str :: acc) lexbuf }
   | ([^ '#' '\n']* as str)
	 { String.concat " " (List.rev (str :: acc)) }

