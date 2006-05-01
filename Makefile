OCAMLMAKEFILE = ../../OCamlMakefile

SOURCES = config_parser.mly config_lexer.mll config.ml
RESULT = plain_config

include ../../Makefile.global
include ../Makefile.inc
LIBINSTALL_FILES += config.cmi

all: bcl ncl

include $(OCAMLMAKEFILE)

