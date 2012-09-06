<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml"
	xmlns:x="http://www.w3.org/1999/xhtml">
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
				<xsl:copy-of select="document('sourceCode.out.xml')/x:html/x:body" />
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
				<xsl:copy-of select="document('toc.out.xml')/x:html/x:body" />
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
				<xsl:copy-of select="document('figures.out.xml')/x:html/x:body" />
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
					<xsl:for-each select="author">
						<xsl:value-of select="text()" />
					</xsl:for-each>
					<xsl:value-of select="'; '" />
					<i>
						<xsl:value-of select="./title" />
					</i>
				</p>
			</xsl:for-each>
		</p>
	</xsl:template>
	


	<xsl:template match="content//*">
		<xsl:copy>
			<xsl:copy-of select="@*" />
			<xsl:apply-templates />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="content//source">
		<a class="source_link">
			<xsl:attribute name="href">
				<xsl:value-of select="concat('#source_',@id)" />		
			</xsl:attribute>
			<xsl:value-of select="concat('[',@id,']')" />
		</a>
	</xsl:template>

	<xsl:template match="content//sourceCode">
		<xsl:variable name="identificator">
			<xsl:number format="1.1.1.1"
				count="chapter | section | subsection | sourceCode" level="multiple" />
		</xsl:variable>
		<p>
				<table class="sourceCode" align="center">
					<xsl:for-each select="tokenize(content, '\n')">
						<xsl:if test=". !=''">
							<tr>
								<td>
									<xsl:value-of select="position()" />
								</td>
								<td>
									<pre class="sourceCodeLine">
										<xsl:value-of select="." />
									</pre>
								</td>
							</tr>
						</xsl:if>
					</xsl:for-each>
				</table>

			<p class="sourceCodeNaming">
				<h6 style="font-size: 0px">
					__sourceCode_
					<xsl:value-of select="$identificator" />
					___
					<xsl:value-of select="title" />
				</h6>
				Source Code
				<xsl:value-of select="$identificator" />
				:
				<xsl:value-of select="title" />
			</p>
		</p>
	</xsl:template>

	<xsl:template match="content//figure">
		<xsl:variable name="src" select="./source/text()" />
		<xsl:variable name="identificator">
			<xsl:number format="1.1.1.1"
				count="chapter | section | subsection | figure" level="multiple" />
		</xsl:variable>

		<p>
			<div class="figureDiv">
				<img class="figure">
					<xsl:attribute name="src">
				<xsl:value-of select="$src" />
				</xsl:attribute>
				</img>
			</div>
			<p class="figureNaming">
				<h6 style="font-size: 0px">
					__figures_
					<xsl:value-of select="$identificator" />
					___
					<xsl:value-of select="title" />
				</h6>
				Figure
				<xsl:value-of select="$identificator" />
				:
				<xsl:value-of select="title" />
			</p>
		</p>
	</xsl:template>
	<xsl:template match="chapter">
		<xsl:variable name="chapterNumber">
			<xsl:number format="1" count="chapter" level="multiple" />
		</xsl:variable>
		<p class="chapter">
			Kapitel
			<xsl:value-of select="$chapterNumber" />
		</p>
		<p class="chapter_paragraph">
			<h1 class="chapter_heading">
				<div style="font-size: 0px">
					<xsl:value-of select="$chapterNumber" />
					.
				</div>
				<xsl:value-of select="@title" />
			</h1>
			<xsl:apply-templates />
		</p>
	</xsl:template>
	<xsl:template match="section">
		<p>
			<h2>
				<xsl:number format="1.1 " count="chapter | section"
					level="multiple" />
				<xsl:value-of select="@title" />
			</h2>
			<xsl:apply-templates />
		</p>
	</xsl:template>
	<xsl:template match="subsection">
		<p>
			<h3>
				<xsl:number format="1.1.1 " count="chapter | section | subsection"
					level="multiple" />
				<xsl:value-of select="@title" />
			</h3>
			<xsl:apply-templates />
		</p>
	</xsl:template>
	<xsl:template match="subsubsection">
		<p>
			<h4>
				<xsl:number format="1.1.1 "
					count="chapter | section | subsection | subsection" level="multiple" />
				<xsl:value-of select="@title" />
			</h4>
			<xsl:apply-templates />
		</p>
	</xsl:template>
</xsl:stylesheet>