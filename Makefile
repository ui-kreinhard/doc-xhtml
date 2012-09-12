SHELL := /bin/bash
SAXON_JAR="/Users/karl-ludwigreinhard/Downloads/SaxonHE9-4-0-4J/saxon9he.jar"
TEMP="/tmp/doc-xhtml"
.PHONY: all 
merge:
	java -jar $(SAXON_JAR) $(TEMP)/document.xml xsl/merger.xsl > $(TEMP)/merged.out.xml
remove_xsd:
	java -jar $(SAXON_JAR) $(TEMP)/merged.out.xml xsl/removeNamespace.xsl  > $(TEMP)/removed.out.xml
dump_outline: 
	java -jar $(SAXON_JAR) $(TEMP)/removed.out.xml xsl/htmlTransformer.xsl > $(TEMP)/temp.out.xml
	wkhtmltopdf --dump-outline $(TEMP)/toc.raw.out.xml --footer-center "[page]" --footer-line $(TEMP)/temp.out.xml /tmp/test.pdf
apply_xsl_outline:
	java -jar $(SAXON_JAR) $(TEMP)/toc.raw.out.xml xsl/lists/toc.xsl > $(TEMP)/toc.out.xml
	java -jar $(SAXON_JAR) $(TEMP)/toc.raw.out.xml xsl/lists/listOfFigures.xsl > $(TEMP)/figures.out.xml
	java -jar $(SAXON_JAR) $(TEMP)/toc.raw.out.xml xsl/lists/listOfSourceCode.xsl > $(TEMP)/sourceCode.out.xml
apply_master_xsl:
	java -jar $(SAXON_JAR) $(TEMP)/removed.out.xml xsl/htmlTransformer.xsl tempDir=$(TEMP) > $(TEMP)/final.out.xml
finalize:
	wkhtmltopdf --footer-center "[page]" --footer-line $(TEMP)/final.out.xml /tmp/test.pdf
all: clean init merge remove_xsd dump_outline apply_xsl_outline apply_master_xsl finalize 

clean: 
	rm -f /tmp/test.pdf
	rm -Rf $(TEMP)
	mkdir $(TEMP)
init:
	cp -Rf $(target)/* $(TEMP)