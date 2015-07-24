<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
                xmlns:gco="http://www.isotc211.org/2005/gco"
                xmlns:gmd="http://www.isotc211.org/2005/gmd"
                xmlns:bfs="http://geonetwork.org/bfs">

  <!-- ============================================================================================ -->

  <xsl:output indent="no" omit-xml-declaration="yes" method="text" encoding="utf-8"/>
  <xsl:strip-space elements="*"/>

  <xsl:template match="bfs:MD_Metadata">
{
  "id": "<xsl:value-of select="gmd:fileIdentifier/gco:CharacterString" />",
  "dspTxt": "<xsl:value-of select="gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString" />",
  "inspireId": "<xsl:value-of select="bfs:layerInformation/bfs:MD_Layer/bfs:inspireID/gco:CharacterString" />",
    <xsl:apply-templates select="bfs:layerInformation/bfs:MD_Layer/bfs:filter" />
  "layerConfig":{
    <xsl:apply-templates select="bfs:layerInformation/bfs:MD_Layer/bfs:layerType" />
    <xsl:apply-templates select="bfs:layerInformation/bfs:MD_Layer/bfs:wfs" />
    <xsl:apply-templates select="bfs:layerInformation/bfs:MD_Layer/bfs:download" />
    "olProperties":{
    <xsl:for-each select="bfs:layerInformation/bfs:MD_Layer/bfs:olProperty/bfs:MD_Property">
      "<xsl:value-of select="bfs:propertyName/gco:CharacterString" />":"<xsl:value-of select="bfs:propertyValue/gco:CharacterString" />"<xsl:if test="position() != last()">,</xsl:if>
    </xsl:for-each>
    },
    "timeSeriesChartProperties":{
    <xsl:for-each select="bfs:layerInformation/bfs:MD_Layer/bfs:timeSeriesChartProperty/bfs:MD_Property">
      "<xsl:value-of select="bfs:propertyName/gco:CharacterString" />":"<xsl:value-of select="bfs:propertyValue/gco:CharacterString" />"<xsl:if test="position() != last()">,</xsl:if>
    </xsl:for-each>
    },
    "barChartProperties":{
      <xsl:for-each select="bfs:layerInformation/bfs:MD_Layer/bfs:barChartProperty/bfs:MD_Property">
        "<xsl:value-of select="bfs:propertyName/gco:CharacterString" />":"<xsl:value-of select="bfs:propertyValue/gco:CharacterString" />"<xsl:if test="position() != last()">,</xsl:if>
      </xsl:for-each>
    }
  }
}
  </xsl:template>

  <xsl:template match="bfs:wfs">
    "wfs":{
      "url":"<xsl:value-of select="concat(bfs:URL/bfs:host/gco:CharacterString,bfs:URL/bfs:path/gco:CharacterString )" />"
    },
  </xsl:template>

  <xsl:template match="bfs:download">
    "download":{
      "url":"<xsl:value-of select="concat(bfs:URL/bfs:host/gco:CharacterString,bfs:URL/bfs:path/gco:CharacterString )" />"
    },
  </xsl:template>

  <!-- Filters -->
  <xsl:template match="bfs:MD_PointInTimeFilter">
  "filter":{
    "type":"pointintime",
    "param":"<xsl:value-of select="bfs:paramName/gco:CharacterString" />",
    "timeformat":"<xsl:value-of select="bfs:date/bfs:TimeFormat/gco:CharacterString" />",
    "timeinstant":"<xsl:value-of select="bfs:date/bfs:TimeInstant/gco:DateTime" />"
  },
  </xsl:template>

  <xsl:template match="bfs:MD_RodosFilter">
  "filter":{
    "type":"rodos",
    "param":"<xsl:value-of select="bfs:paramName/gco:CharacterString" />",
    "url":"<xsl:value-of select="concat(bfs:URL/bfs:host/gco:CharacterString,bfs:URL/bfs:path/gco:CharacterString )" />"
  },
  </xsl:template>

  <xsl:template match="bfs:MD_TimeRangeFilter">
  "filter":{
    "type":"timerange",
    "param":"<xsl:value-of select="bfs:paramName/gco:CharacterString" />",
    "interval":"<xsl:value-of select="bfs:interval/gco:Integer" />",
    "unit":"<xsl:value-of select="bfs:unit/gco:CharacterString" />",
    "mindatetimeformat":"<xsl:value-of select="bfs:minDate/bfs:TimeFormat/gco:CharacterString" />",
    "mindatetimeinstant":"<xsl:value-of select="bfs:minDate/bfs:TimeInstant/gco:DateTime" />",
    "maxdatetimeformat":"<xsl:value-of select="bfs:maxDate/bfs:TimeFormat/gco:CharacterString" />",
    "maxdatetimeinstant":"<xsl:value-of select="bfs:maxDate/bfs:TimeInstant/gco:DateTime" />"
  },
  </xsl:template>

  <xsl:template match="bfs:MD_ValueFilter">
  "filter":{
    "type":"value",
    "param":"<xsl:value-of select="bfs:paramName/gco:CharacterString" />",
    <xsl:for-each select="bfs:value">
    "value":<xsl:value-of select="gco:CharacterString" />,
    </xsl:for-each>
    "defaultValue":"<xsl:value-of select="bfs:defaultValue/gco:CharacterString" />",
    "allowMultipleSelect":"<xsl:apply-templates select="bfs:allowMultipleSelect/gco:Boolean" />"
  },
  </xsl:template>


  <!-- Layer type templates -->
  <xsl:template match="bfs:MD_WMSLayerType">
    "wms":{
      "url":"<xsl:value-of select="concat(bfs:URL/bfs:host/gco:CharacterString,bfs:URL/bfs:path/gco:CharacterString )" />" ,
      "layers":"<xsl:value-of select="bfs:layer/gco:CharacterString" />",
      "transparent":<xsl:value-of select="bfs:transparent/gco:Boolean" />,
      "version":"<xsl:value-of select="bfs:version/gco:CharacterString" />",
      "styles":"<xsl:value-of select="bfs:styles/gco:CharacterString" />",
      "format":"<xsl:value-of select="bfs:format/gco:CharacterString" />"
    },
  </xsl:template>

  <xsl:template match="bfs:MD_WMSLayerType">
    "wms":{
      "url":"<xsl:value-of select="concat(bfs:URL/bfs:host/gco:CharacterString,bfs:URL/bfs:path/gco:CharacterString )" />" ,
      "layers":"<xsl:value-of select="bfs:layer/gco:CharacterString" />",
      "transparent":<xsl:apply-templates select="bfs:transparent/gco:Boolean" />,
      "version":"<xsl:value-of select="bfs:version/gco:CharacterString" />",
      "styles":"<xsl:value-of select="bfs:styles/gco:CharacterString" />",
      "format":"<xsl:value-of select="bfs:format/gco:CharacterString" />"
    },
  </xsl:template>


  <xsl:template match="bfs:MD_VectorLayerType">
    "vector":{
    "url":"<xsl:value-of select="concat(bfs:URL/bfs:host/gco:CharacterString,bfs:URL/bfs:path/gco:CharacterString )" />" ,
    "layers":"<xsl:value-of select="bfs:layer/gco:CharacterString" />",
    "styles":"<xsl:value-of select="bfs:styles/gco:CharacterString" />",
    },
  </xsl:template>

  <xsl:template match="bfs:MD_WMTSLayerType">
    "wmts":{
      "url":"<xsl:value-of select="concat(bfs:URL/bfs:host/gco:CharacterString,bfs:URL/bfs:path/gco:CharacterString )" />" ,
      "layers":"<xsl:value-of select="bfs:layer/gco:CharacterString" />",
      "tilematrixset":"<xsl:value-of select="bfs:tilematrixset/gco:CharacterString" />",
      "transparent":<xsl:apply-templates select="bfs:transparent/gco:Boolean" />,
      "version":"<xsl:value-of select="bfs:version/gco:CharacterString" />",
      "styles":"<xsl:value-of select="bfs:styles/gco:CharacterString" />",
      "format":"<xsl:value-of select="bfs:format/gco:CharacterString" />"
    },
  </xsl:template>

  <xsl:template match="gco:Boolean">
    <xsl:choose>
      <xsl:when test=". = 'true'">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="@*|node()">
      <xsl:apply-templates select="@*|node()[name(self::*)!='geonet:info']"/>
  </xsl:template>
</xsl:stylesheet>