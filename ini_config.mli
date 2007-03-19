(*
 * (c) 2005-2007 Anastasia Gornostaeva. <ermine@ermine.pp.ru>
 *)

type ini = (string * (string * string) list) list

exception IniError of int

val get_value : ini -> string -> string -> string

val get_value_list : ini -> string -> string -> string list

val parse : string -> ini

