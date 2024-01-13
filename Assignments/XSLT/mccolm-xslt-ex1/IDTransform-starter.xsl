<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:template match="poemTitle">
        <title>
            <xsl:apply-templates />
            
        </title>
    </xsl:template> 
    
    <xsl:template match="line">
        <lb num="{preceding-sibling::line => count() + 1}"/>
        <xsl:apply-templates />
        
    </xsl:template>
    
    <xsl:template match="body">
        <xsl:apply-templates/>
    </xsl:template>
    
<!--   
    I couldn't get the last part to work. I must have forgot what to do for this part :( - MMM 11/2/23    
    <xsl:template match="poem">
            <xsl:attribute name="{xml:id => count()}">
                <xsl:text>p-</xsl:text>
            </xsl:attribute>
    </xsl:template>-->
    
   
  
 
   
</xsl:stylesheet>