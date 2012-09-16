<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml"
	xmlns:h="http://www.w3.org/1999/xhtml" xmlns:x="http://www.w3.org/1999/xhtml">
	<xsl:param name="tempDir" />
   <xsl:include href="includeManifest.xsl" />
	<xsl:output indent="yes" method="xhtml" />

	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="layout.css" />
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
				<title>Insert title here</title>
				<script><![CDATA[
  function subst() {
    var vars={};
    var x=document.location.search.substring(1).split('&');
    for (var i in x) {var z=x[i].split('=',2);vars[z[0]] = unescape(z[1]);}
    var x=['frompage','topage','page','webpage','section','subsection','subsubsection'];
    for (var i in x) {
      var y = document.getElementsByClassName(x[i]);
      for (var j=0; j<y.length; ++j) y[j].textContent = vars[x[i]];
    }
  }
  ]]>
				</script>
			</head>
			<body style="border:0; margin: 0;" onload="subst()">
				<xsl:apply-templates />
			</body>
		</html>
	</xsl:template>

	<xsl:template match="/document/listOfSourceCode">
		<p class="chapter">
			<div style="font-size: 0px">dont show me</div>
		</p>
		<p class="chapter_paragraph">
			<h1 class="chapter_heading">Source Code Listings</h1>

			<ol class="toc">
				<xsl:copy-of
					select="document(concat($tempDir,'/sourceCode.out.xml'))/x:html/x:body" />
			</ol>
		</p>
	</xsl:template>

	<xsl:template match="/document/tableOfContent">
		<p class="chapter">
			<div style="font-size: 0px">dont show me</div>
		</p>
		<p class="chapter_paragraph">
			<h1 class="chapter_heading">Table of content</h1>

			<ol class="toc">
				<xsl:copy-of
					select="document(concat($tempDir,'/toc.out.xml'))/x:html/x:body" />
			</ol>
		</p>
	</xsl:template>

	<xsl:template match="/document/listOfFigures">
		<p class="chapter">
			<div style="font-size: 0px">dont show me</div>
		</p>
		<p class="chapter_paragraph">
			<h1 class="chapter_heading">List of Figures</h1>

			<ol class="toc">
				<xsl:copy-of
					select="document(concat($tempDir,'/figures.out.xml'))/x:html/x:body" />
			</ol>
		</p>
	</xsl:template>
	<xsl:template match="/document/bibliography">
		<p class="chapter_paragraph">
			<p class="chapter">
				<div style="font-size: 0px">dont show me</div>
			</p>
			<h1 class="chapter_heading">
				Bibliography
			</h1>

			<xsl:for-each select="source">
				<p>
					<xsl:variable name="localName" select="'name'" />
					<a>
						<xsl:attribute name="{$localName}">
						<xsl:value-of select="concat('source_',./sourceId/text())" />
					</xsl:attribute>
						<xsl:value-of select="concat('[',./sourceId/text(),'] ')" />
					</a>
					<xsl:if test="./url">
					<xsl:value-of select="./url/text()" />
						<xsl:value-of select="'; '" />
					</xsl:if>
					<xsl:for-each select="author">
						<xsl:value-of select="text()" />
						<xsl:value-of select="'; '" />
					</xsl:for-each>
						
					<i>
						<xsl:value-of select="./title" />
					</i>
				</p>
			</xsl:for-each>
		</p>
	</xsl:template>





</xsl:stylesheet>