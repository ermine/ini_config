{
(*                                                                          *)
(* (c) 2005 Anastasia Gornostaeva. <ermine@ermine.pp.ru>                    *)
(*                                                                          *)

open Config_parser
}

let space = [' ' '\t' '\n' '\r']
let ident = ['a'-'z' '_']
let v = ['a'-'z' 'A'-'Z' '_' '-' '0'-'9' '.' '@' '/']

rule token = parse
   | space                                            { token lexbuf }
   | '='                                              { EQ }
   | ','                                              { COMMA }
   | '#'                                              { let _ = 
							   comment lexbuf in
							   token lexbuf }
   | ident+ as key                                    { KEY key }
   | v+ as value                                      { VALUE value }
   | eof                                              { EOF }

and comment = parse
   | '\n'                                              { () }
   | _                                                 { comment lexbuf }
