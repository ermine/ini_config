OCAMLMAKEFILE = ../../OCamlMakefile

SOURCES	= ini_parser.mly ini_lexer.mll ini_config.mli ini_config.ml
RESULT	= ini_config

include ../../Makefile.global
include ../Makefile.inc
LIBINSTALL_FILES += config.cmi

all: bcl ncl

test: ini_config.cma test.ml
	ocamlc ini_config.cma test.ml -o test

include $(OCAMLMAKEFILE)

