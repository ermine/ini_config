%{
(*                                                                          *)
(* (c) 2005 Anastasia Gornostaeva. <ermine@ermine.pp.ru>                    *)
(*                                                                          *)

let parse_error msg =
   Printf.printf "%s %d %d\n"
      "Syntax error" 
      (Parsing.symbol_start ()) 
      (Parsing.symbol_end ())

%}

%token <string> KEY
%token <string> VALUE
%token EQ EOL EOF COMMA COMMENT

%start config
%type <(string * string list) list> config

%%
config:
| file EOF                     { $1 }

file:
| /* empty */                  { [] }
| lines                        { $1 }

lines:
| line                         { [$1] }
| lines line                   { $2 :: $1 }

line:
| KEY EQ params                { $1, $3 }

params:
| VALUE                        { [$1] }
| params COMMA VALUE           { $3 :: $1 }
