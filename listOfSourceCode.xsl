<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:outline="http://code.google.com/p/wkhtmltopdf/outline"
    xmlns="http://www.w3.org/1999/xhtml">
       <xsl:output method="xhtml"/>
    <xsl:template match="outline:outline">
        <html>
            <head>
                <link rel="stylesheet" type="text/css"
                    href="file:///Users/karl-ludwigreinhard/documents/htmlTest/htmlTest/layout.css" />

                <title>Table of Content</title>
                <style>
                    * {

                    font-family: times new roman;
                    }
                    ol.toc li {
                    list-style-type:
                    none;
                    clear:left;
                    border-bottom:dashed 1px #000;
                    height:1.05em;
                    margin-top:00px;
                    position:relative;
                    }
                    ol {
                    list-style-type: none;

                    }
                    ol.toc a, ol.toc span {
                    color: black;
                    background:#fff;
                    padding:0 3px 0
                    0;
                    float:left;
                    position:absolute;
                    text-decoration:none;
                    }
                    ol.toc a {
                    color: black;
                    font-color: black;
                    padding:0 0 0 3px;
                    right:0;
                    }
                    ol.toc ol
                    {
                    list-style-type: none;
                    margin:0.2em 0 0em 39px;
                    padding:0;
                    background:#fff;
                    float:left;
                    display:block;
                    width:94%;
                    }
        </style>
            </head>
            <body>

             
                        <xsl:for-each select="outline:item//outline:item">
                            <xsl:if test="@title!='' and starts-with(@title,'__sourceCode')">
                                <li>
                                    <span>
                                        <xsl:value-of select="replace(replace(@title,'___',' '), '__sourceCode_ ','')" />
                                    </span>
                                    <a href="#">
                                        <xsl:value-of select="@page" />
                                    </a>
                                </li>
                            </xsl:if>
                        </xsl:for-each>
              
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
