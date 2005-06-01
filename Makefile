OCAMLMAKEFILE = ../../OCamlMakefile

SOURCES = config_parser.mly config_lexer.mll config.ml
RESULT = config_file

all: ncl

include $(OCAMLMAKEFILE)

