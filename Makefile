# Makefile for creating an ATLAS LaTeX document
#------------------------------------------------------------------------------
# $Id: Makefile 301586 2014-08-18 17:36:36Z brock $
# $HeadURL: svn+ssh://svn.cern.ch/reps/atlasgroups/pubcom/latex/atlasnote/trunk/Makefile $
#------------------------------------------------------------------------------
# By default makes mydocument.pdf using target run_pdflatex
# Replace mydocument with your main filename or add another target set
# Use "make clean" to cleanup.
# "make cleanall" also deletes the PDF file $(BASENAME).pdf.

LATEX    = latex
PDFLATEX = pdflatex
BIBTEX   = bibtex
DVIPS    = dvips
DVIPDF   = dvipdf

BASENAME = mydocument

# Default target - make mydocument.pdf with pdflatex
default: run_pdflatex

.PHONY: new clean

new:
	# cp template/atlas-document.tex $(BASENAME).tex
	sed s/atlas-document/$(BASENAME)/ template/atlas-document.tex >$(BASENAME).tex
	cp template/atlas-metadata.tex $(BASENAME)-metadata.tex
	touch $(BASENAME).bib
	touch $(BASENAME)-defs.sty
	
run_pdflatex: $(BASENAME).pdf
	@echo "Made $<"

run_latex: $(BASENAME).dvi
	$(DVIPDF) -sPAPERSIZE=a4 -dPDFSETTINGS=/prepress ${BASENAME}
	@echo "Made $<"

# Standard Latex targets
%.pdf:	%.tex *.bib
	$(PDFLATEX) $<
	$(BIBLATEX) $(basename $<)
	$(PDFLATEX) $<
	$(PDFLATEX) $<

%.dvi:	%.tex 
	$(LATEX)    $<
	$(BIBLATEX) $(basename $<)
	$(LATEX)    $<
	$(LATEX)    $<

%.bbl:	%.tex *.bib
	$(LATEX) $*
	$(BIBTEX) $*

%.ps:	%.dvi
	$(DVIPS) $< -o $@

clean:
	-rm *.dvi *.toc *.aux *.log *.out 
		*.bbl *.blg *.brf *.bcf \
		*.cb *.ind *.idx *.ilg *.inx \
		*.synctex.gz *~ ~* spellTmp 
	
cleanall: clean
	-rm $(BASENAME).pdf
