<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:doc="http://document.schema" xmlns:xi="http://www.w3.org/2001/XInclude"
	xmlns:xlink="http://www.w3.org/1999/xlink" xsi:schemaLocation="http://document.schema document.xsd">

	<xsl:output method="xml" indent="yes" />
	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>


	<xsl:template match="*//doc:include">
		<xsl:variable name="parentName" select="parent::node()/name()" />
<!--         <xsl:value-of select="$parentName"/>
        <xsl:value-of select="./@src"/> -->
		<xsl:copy-of xmlns="http://document.schema" select="document(./@src)//*[name()=$parentName]/*" />
		
	</xsl:template>

	<xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>