{
(*
 * (c) 2005-2007 Anastasia Gornostaeva. <ermine@ermine.pp.ru>
 *)

open Ini_parser

let trim str =
   let len = String.length str in
   let rec aux_start i =
      if i < len then
	 if str.[i] = ' ' || str.[i] = '\t' || str.[i] = '\n' then
	    aux_start (i+1)
	 else
	    i
      else
	 i
   in
   let rec aux_end start i =
      if i > start then
	 if str.[i] = ' ' || str.[i] = '\t' || str.[i] = '\n' then
	    aux_end start (i-1)
	 else
	    i+1
      else
	 i
   in
      if len = 0 then
	 ""
      else
	 let start = aux_start 0 in
	 let last = aux_end start (len-1) in
	    Printf.printf "trim: [%s] %d %d\n" str start last;
	    String.sub str start last
}

let space = [' ' '\t']
let eol = space* ('#' [^ '\n']*)? '\r'? '\n'

(* almost as XML tag *)
let ident = ['a'-'z' 'A'-'Z' '_' ':'] ['a'-'z' 'A'-'Z' '0'-'9' '.' '-' '_' ':']*

rule token = parse
   | '[' (ident as ident) ']'
	 { 
	    print_endline ident;
	    Section ident }
   | (ident as ident) space* '=' space*
	 { 
	    print_endline ident;
	    let value = value [] lexbuf in
	      KeyValue (ident, value) }
   | eol+
	 { 
	    print_endline "EOL";
	    EOL }
   | eof
	 { EOF }

and value acc = parse
   | ([^  '#' '\n']* as str) eol+ space+ 
	 { value (trim str :: acc) lexbuf }
   | ([^ '#' '\n']* as str)
	 { String.concat " " (List.rev (trim str :: acc)) }

