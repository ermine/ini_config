(*
 * (c) 2005-2007 Anastasia Gornostaeva. <ermine@ermine.pp.ru>
 *)

type ini = (string * (string * string) list) list

exception IniError of int

val getvalue : ini -> string -> string -> string

val parse : string -> ini

