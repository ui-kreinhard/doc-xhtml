<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml"
	xmlns:h="http://www.w3.org/1999/xhtml" xmlns:x="http://www.w3.org/1999/xhtml">
	<xsl:output method="xhtml" />
	<xsl:template match="content//*">
		<xsl:element name="{name(.)}" namespace="http://www.w3.org/1999/xhtml">
			<xsl:copy-of select="@*" />
			<xsl:apply-templates />
		</xsl:element>
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
</xsl:stylesheet>