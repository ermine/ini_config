/*
* (c) 2005-2007 Anastasia Gornostaeva. <ermine@ermine.pp.ru>
*/

/*
%{
   let parse_error msg =
      raise (IniError
		((Parsing.symbol_start ()),
		 (Parsing.symbol_end ())))
%}
*/

%token <string> Section
%token <string * string> KeyValue
%token EOL EOF

%start config_file
%type <(string * (string * string) list) list> config_file

%%
config_file:
| unit EOF                   { $1 }
| EOL unit EOF               { $2 }

unit:
|                            { [] }
| section EOL unit           { $1 :: $3 }
| section                    { [$1] }

section:
| Section EOL keyvaluelist   { $1, $3 }

keyvaluelist:
| KeyValue EOL keyvaluelist  { $1 :: $3 }
| KeyValue EOL               { [$1] }
