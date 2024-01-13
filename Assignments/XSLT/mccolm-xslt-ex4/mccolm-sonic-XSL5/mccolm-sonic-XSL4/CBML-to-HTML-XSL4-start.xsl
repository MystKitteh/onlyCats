<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:cbml="http://www.cbml.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>

<xsl:variable name="cbml-collection" as="document-node()+" select="collection('cbml/?select=*.xml')"/>

 
   
   <xsl:template match="/">
       <html>
           <head>
               <title>A New CBML Transformation!</title>
               <link rel="stylesheet" type="text/css" href="style.css"/> 
           </head>
           <body>
         
               <h1><xsl:apply-templates select="descendant::titleStmt/title"/></h1> 
               
          <div id="characterTable">
              <xsl:variable name="docTree" as="document-node()" select="current()"/>
              <xsl:variable name="myData" as="item()+" select=".//cbml:panel/@characters ! normalize-space() ! 
                  tokenize(., ' ') => distinct-values() => sort()"/>

              <table>
                  <tr>
                      <th>Character</th>
                      <th>Panels</th>
                  </tr>
                  <xsl:for-each select="$myData"> 
                      
                      <tr>
                          
                          <td><xsl:value-of select="substring-after(., '#')"/>
   
                          </td>
                              
                              <td>
                                  <ul>
                                      <xsl:apply-templates select="$docTree//div[@type='page' and cbml:panel[contains(@characters, current()) ]]" mode="toc">
                                          <xsl:with-param name="currentCharacter" as="item()" select="current()"/>  
                                      </xsl:apply-templates>
                              </ul>
                          </td>
                          
                          
                          
                      </tr>
                  </xsl:for-each>
              </table>
      
          </div>     
 
          <div id="reading-view">        
            <xsl:apply-templates select="descendant::body"/>
              

          
          </div>
   
           </body>
       </html>
   </xsl:template> 
    
    <xsl:template match="div[@type='page']" mode="toc">
        <xsl:param name="currentCharacter"/>
        
        <li>Page <xsl:value-of select="@xml:id ! substring-after(., '_')"/>
            
            <ul>
                <xsl:apply-templates select="descendant::cbml:panel" mode="toc">
                    
                    <xsl:with-param name="currentCharacter" select="$currentCharacter"/>
                </xsl:apply-templates>
            </ul>   
        </li>
        
        
        
    </xsl:template> 
    
    <xsl:template match="cbml:panel" mode="toc">
        <xsl:param name="currentCharacter"/>
        <xsl:if test="@characters ! contains(., $currentCharacter)">
            <li>
                <a href="#{ancestor::div/@xml:id}-panel-{@n}">Panel <xsl:value-of select="@n"/></a>
            </li>
        </xsl:if>
        
    </xsl:template>
    <xsl:template match="div[@type='page']">
        <section class="{@type}" id="{@xml:id}">
             <xsl:apply-templates/>
        </section>
    </xsl:template>
    

    <xsl:template match="figure[not(parent::p)]">
        <figure class="{@type}">
            <xsl:apply-templates/>
            
        </figure>
  
    </xsl:template>
    
    <xsl:template match="p | figDesc[not(ancestor::p)]">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="div[@type='page']">
        <section class="{@type}" id="{@xml:id}">
            <xsl:apply-templates/>
            
        </section>
    </xsl:template>
    
    <xsl:template match="cbml:panel">
        <div class="panel" id="{ancestor::div/@xml:id}-panel-{@n}">
            
            <xsl:apply-templates/>            
            
        </div>
        
    </xsl:template>
    
    <xsl:template match="cbml:caption">
        <p class="cbml-caption">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="note">
        <p class="{@type}">
            <xsl:apply-templates/>
        </p>  
    </xsl:template>
    
    <xsl:template match="sound">
        <span class="{name()}" style="color:red">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    
    <xsl:template match="p | figDesc[not(ancestor::p)]">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="figure[not(parent::p)]">
        <figure class="{@type}">
            <xsl:apply-templates/>
            
        </figure>
        
    </xsl:template>
   
    
</xsl:stylesheet>