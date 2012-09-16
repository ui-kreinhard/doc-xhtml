<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:gen="dummy-namespace-for-the-generated-xslt"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xout="http://www.w3.org/1999/XSL/Transform">
	<xsl:namespace-alias stylesheet-prefix="gen"
		result-prefix="xsl" />

	<xsl:output method="xml" indent="yes" />
	<xsl:template match="/">
		<gen:stylesheet version="1.0">
			<xsl:for-each select="collection('../includes/?select=*.xsl')">
				<gen:include href="{concat('includes/',tokenize(document-uri(.), '/')[last()])}"/>
			</xsl:for-each>
		</gen:stylesheet>
	</xsl:template>
</xsl:stylesheet>