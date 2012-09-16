<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml"
	xmlns:h="http://www.w3.org/1999/xhtml" xmlns:x="http://www.w3.org/1999/xhtml">
	<xsl:output method="xhtml" />
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