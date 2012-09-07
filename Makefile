SAXON_JAR="/home/karl/bin/saxon9he.jar"
.PHONY: all 
merge:
	java -jar $(SAXON_JAR) $(target) merger.xsl > merged.out.xml
remove_xsd:
	java -jar $(SAXON_JAR) merged.out.xml removeNamespace.xsl  > removed.out.xml
dump_outline: 
	java -jar $(SAXON_JAR) removed.out.xml htmlTransformer.xsl > temp.out.xml
	wkhtmltopdf --dump-outline toc.raw.out.xml --footer-html footer.html --header-html header.html temp.out.xml /tmp/test.pdf
apply_xsl_outline:
	java -jar $(SAXON_JAR) toc.raw.out.xml toc.xsl > toc.out.xml
	java -jar $(SAXON_JAR) toc.raw.out.xml listOfFigures.xsl > figures.out.xml
	java -jar $(SAXON_JAR) toc.raw.out.xml listOfSourceCode.xsl > sourceCode.out.xml
apply_master_xsl:
	java -jar $(SAXON_JAR) removed.out.xml ./htmlTransformer.xsl > final.out.xml
finalize:
	wkhtmltopdf --footer-html footer.html --header-html header.html final.out.xml /tmp/test.pdf
all: clean merge remove_xsd dump_outline apply_xsl_outline apply_master_xsl finalize

generate: 
	./generate $(target)
clean: 
	rm -Rf *.out.xml
