#------------------------------------------------------------------------------
# Makefile to make atlas_bibtex documentation
#------------------------------------------------------------------------------

BASENAME = atlas_bibtex

.PHONY: clean cleanpdf

atlas_bibtex:
	make -f ../Makefile run_latexmk BASENAME=$(BASENAME)

clean:
	make -f ../Makefile clean
	
cleanpdf:
	-rm $(BASENAME).pdf

cleanall: clean cleanpdf
