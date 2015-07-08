<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:gmd="http://www.isotc211.org/2005/gmd" 
                xmlns:gts="http://www.isotc211.org/2005/gts"
                xmlns:gco="http://www.isotc211.org/2005/gco" 
                xmlns:gmx="http://www.isotc211.org/2005/gmx"
                xmlns:srv="http://www.isotc211.org/2005/srv" 
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:gml="http://www.opengis.net/gml" 
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:gn="http://www.fao.org/geonetwork"
                xmlns:bfs="http://geonetwork.org/bfs" 
                xmlns:gn-fn-metadata="http://geonetwork-opensource.org/xsl/functions/metadata"
                xmlns:gn-fn-iso19139.bfs="http://geonetwork-opensource.org/xsl/functions/profiles/iso19139.bfs"
                xmlns:saxon="http://saxon.sf.net/" extension-element-prefixes="saxon"
                exclude-result-prefixes="#all">

  <xsl:include href="layout.xsl"/>

  <!--
    Load the schema configuration for the editor.
    Same configuration as ISO19139 here.
      -->
  <xsl:template name="get-iso19139.bfs-configuration">
    <xsl:message>get-iso19139.bfs-configuration</xsl:message>
    <xsl:copy-of select="document('../../iso19139.bfs/layout/config-editor.xml')"/>
    <xsl:message>FIN get-iso19139.bfs-configuration</xsl:message>
  </xsl:template>


  <!-- Dispatch to the current profile mode -->
  <xsl:template name="dispatch-iso19139.bfs">
    <xsl:param name="base" as="node()"/>
    <xsl:message>dispatch-iso19139.bfs</xsl:message>
    <xsl:apply-templates mode="mode-iso19139.bfs" select="$base"/>
    <xsl:message>FIN dispatch-iso19139.bfs</xsl:message>
  </xsl:template>


  <!-- The following templates usually delegates all to iso19139. -->
  <xsl:template name="evaluate-iso19139.bfs">
    <xsl:param name="base" as="node()"/>
    <xsl:param name="in"/>
    <xsl:message>evaluate-iso19139.bfs</xsl:message>
   <!-- <xsl:message>in xml <xsl:copy-of select="$base"></xsl:copy-of></xsl:message>
    <xsl:message>search for <xsl:copy-of select="$in"></xsl:copy-of></xsl:message>-->
    <xsl:variable name="nodeOrAttribute" select="saxon:evaluate(concat('$p1', $in), $base)"/>
    <xsl:choose>
      <xsl:when test="$nodeOrAttribute/*">
        <xsl:copy-of select="$nodeOrAttribute"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$nodeOrAttribute"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:message>FIN evaluate-iso19139.bfs</xsl:message>
  </xsl:template>

  <xsl:template name="evaluate-iso19139.bfs-boolean">
    <xsl:param name="base" as="node()"/>
    <xsl:param name="in"/>

    <xsl:message>evaluate-iso19139-boolean</xsl:message>
    <xsl:call-template name="evaluate-iso19139-boolean">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="in" select="$in"/>
    </xsl:call-template>
    <xsl:message>FIN evaluate-iso19139-boolean</xsl:message>
  </xsl:template>


</xsl:stylesheet>