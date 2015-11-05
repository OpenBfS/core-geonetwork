<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
                xmlns:gco="http://www.isotc211.org/2005/gco"
                xmlns:gmd="http://www.isotc211.org/2005/gmd"
                xmlns:bfs="http://geonetwork.org/bfs"
                xmlns:util="java:org.fao.geonet.util.XslUtil">

  <!-- ============================================================================================ -->

  <xsl:output indent="no" omit-xml-declaration="yes" method="text" encoding="utf-8"  media-type="text/x-json"/>
  <xsl:strip-space elements="*"/>

  <xsl:template match="bfs:MD_Metadata">
{
  "id": "<xsl:apply-templates select="gmd:fileIdentifier/gco:CharacterString" />",
  "dspTxt": "<xsl:apply-templates select="gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString" />",
  "inspireId": "<xsl:apply-templates select="bfs:layerInformation/bfs:MD_Layer/bfs:inspireID/gco:CharacterString" />",
  "filters": [
    <xsl:for-each select="bfs:layerInformation/bfs:MD_Layer/bfs:filter[bfs:*]">
      <xsl:apply-templates select="." /><xsl:if test="position() != last()">,</xsl:if>
    </xsl:for-each>
    ],
  "layerConfig":{
    <xsl:apply-templates select="bfs:layerInformation/bfs:MD_Layer/bfs:layerType" />
    <xsl:apply-templates select="bfs:layerInformation/bfs:MD_Layer/bfs:wfs" />
    <xsl:apply-templates select="bfs:layerInformation/bfs:MD_Layer/bfs:download" />
    "olProperties":{
    <xsl:for-each select="bfs:layerInformation/bfs:MD_Layer/bfs:olProperty/bfs:MD_Property">
      "<xsl:apply-templates select="bfs:propertyName/gco:CharacterString" />":"<xsl:apply-templates select="bfs:propertyValue/gco:CharacterString" />"<xsl:if test="position() != last()">,</xsl:if>
    </xsl:for-each>
    },
    "timeSeriesChartProperties":{
    <xsl:for-each select="bfs:layerInformation/bfs:MD_Layer/bfs:timeSeriesChartProperty/bfs:MD_Property">
      "<xsl:apply-templates select="bfs:propertyName/gco:CharacterString" />":"<xsl:apply-templates select="bfs:propertyValue/gco:CharacterString" />"<xsl:if test="position() != last()">,</xsl:if>
    </xsl:for-each>
    },
    "barChartProperties":{
      <xsl:for-each select="bfs:layerInformation/bfs:MD_Layer/bfs:barChartProperty/bfs:MD_Property">
        "<xsl:apply-templates select="bfs:propertyName/gco:CharacterString" />":"<xsl:apply-templates select="bfs:propertyValue/gco:CharacterString" />"<xsl:if test="position() != last()">,</xsl:if>
      </xsl:for-each>
    }
  }
}
  </xsl:template>

  <xsl:template match="bfs:wfs">
    <xsl:variable name="host"><xsl:apply-templates select="bfs:URL/bfs:host/gco:CharacterString" /></xsl:variable>
    <xsl:variable name="path"><xsl:apply-templates select="bfs:URL/bfs:path/gco:CharacterString" /></xsl:variable>

    "wfs":{
      "url":"<xsl:value-of select="concat(normalize-space($host),normalize-space($path))" />"
    },
  </xsl:template>

  <xsl:template match="bfs:download">
    <xsl:variable name="host"><xsl:apply-templates select="bfs:URL/bfs:host/gco:CharacterString" /></xsl:variable>
    <xsl:variable name="path"><xsl:apply-templates select="bfs:URL/bfs:path/gco:CharacterString" /></xsl:variable>

    "download":{
    "url":"<xsl:value-of select="concat(normalize-space($host),normalize-space($path))" />",
      "filterFieldStart":"<xsl:apply-templates select="bfs:filterFieldStart/gco:CharacterString" />",
      "filterFieldEnd":"<xsl:apply-templates select="bfs:filterFieldEnd/gco:CharacterString" />"
    },
  </xsl:template>

  <!-- Filters -->
  <xsl:template match="bfs:MD_PointInTimeFilter">
  {
    "type":"pointintime",
    "param":"<xsl:apply-templates select="bfs:paramName/gco:CharacterString" />",
    "interval":"<xsl:value-of select="bfs:interval/gco:Integer" />",
    "unit":"<xsl:apply-templates select="bfs:unit/gco:CharacterString" />",
    "mindatetimeformat":"<xsl:apply-templates select="bfs:minDate/bfs:TimeFormat/gco:CharacterString" />",
    "mindatetimeinstant":"<xsl:apply-templates select="bfs:minDate/bfs:TimeInstant/gco:CharacterString" />",
    "maxdatetimeformat":"<xsl:apply-templates select="bfs:maxDate/bfs:TimeFormat/gco:CharacterString" />",
    "maxdatetimeinstant":"<xsl:apply-templates select="bfs:maxDate/bfs:TimeInstant/gco:CharacterString" />",
    "defaulttimeformat":"<xsl:apply-templates select="bfs:defaultValue/bfs:TimeFormat/gco:CharacterString" />",
    "defaulttimeinstant":"<xsl:apply-templates select="bfs:defaultValue/bfs:TimeInstant/gco:CharacterString" />"
  }
  </xsl:template>

  <xsl:template match="bfs:MD_RodosFilter">
    <xsl:variable name="host"><xsl:apply-templates select="bfs:URL/bfs:host/gco:CharacterString" /></xsl:variable>
    <xsl:variable name="path"><xsl:apply-templates select="bfs:URL/bfs:path/gco:CharacterString" /></xsl:variable>

    {
    "type":"rodos",
    "param":"<xsl:apply-templates select="bfs:paramName/gco:CharacterString" />",
    "url":"<xsl:value-of select="concat(normalize-space($host),normalize-space($path))" />"
  }
  </xsl:template>

  <xsl:template match="bfs:MD_TimeRangeFilter">
  {
    "type":"timerange",
    "param":"<xsl:apply-templates select="bfs:paramName/gco:CharacterString" />",
    "interval":"<xsl:value-of select="bfs:interval/gco:Integer" />",
    "unit":"<xsl:apply-templates select="bfs:unit/gco:CharacterString" />",
    "maxduration":"<xsl:apply-templates select="bfs:maxDuration/gco:CharacterString" />",
    "mindatetimeformat":"<xsl:apply-templates select="bfs:minDate/bfs:TimeFormat/gco:CharacterString" />",
    "mindatetimeinstant":"<xsl:apply-templates select="bfs:minDate/bfs:TimeInstant/gco:CharacterString" />",
    "maxdatetimeformat":"<xsl:apply-templates select="bfs:maxDate/bfs:TimeFormat/gco:CharacterString" />",
    "maxdatetimeinstant":"<xsl:apply-templates select="bfs:maxDate/bfs:TimeInstant/gco:CharacterString" />",
    "defaultstarttimeformat":"<xsl:apply-templates select="bfs:defaultStartValue/bfs:TimeFormat/gco:CharacterString" />",
    "defaultstarttimeinstant":"<xsl:apply-templates select="bfs:defaultStartValue/bfs:TimeInstant/gco:CharacterString" />",
    "defaultendtimeformat":"<xsl:apply-templates select="bfs:defaultEndValue/bfs:TimeFormat/gco:CharacterString" />",
    "defaultendtimeinstant":"<xsl:apply-templates select="bfs:defaultEndValue/bfs:TimeInstant/gco:CharacterString" />"
  }
  </xsl:template>

  <xsl:template match="bfs:MD_ValueFilter">
  {
    "type":"value",
    "param":"<xsl:apply-templates select="bfs:paramName/gco:CharacterString" />",
    "alias":"<xsl:apply-templates select="bfs:paramAlias/gco:CharacterString" />",
    "defaultValue":"<xsl:apply-templates select="bfs:defaultValue/gco:CharacterString" />",
    "allowedValues":"<xsl:apply-templates select="bfs:allowedValues/gco:CharacterString" />",
    "operator":"<xsl:apply-templates select="bfs:operator/gco:CharacterString" />",
    "allowMultipleSelect":"<xsl:apply-templates select="bfs:allowMultipleSelect/gco:Boolean" />"
  }
  </xsl:template>


  <!-- Layer type templates -->
  <xsl:template match="bfs:MD_WMSLayerType">
    <xsl:variable name="host"><xsl:apply-templates select="bfs:URL/bfs:host/gco:CharacterString" /></xsl:variable>
    <xsl:variable name="path"><xsl:apply-templates select="bfs:URL/bfs:path/gco:CharacterString" /></xsl:variable>

    "wms":{
      "url":"<xsl:value-of select="concat(normalize-space($host),normalize-space($path))" />" ,
      "layers":"<xsl:apply-templates select="bfs:layer/gco:CharacterString" />",
      "transparent":"<xsl:apply-templates select="bfs:transparent/gco:Boolean" />",
      "version":"<xsl:apply-templates select="bfs:version/gco:CharacterString" />",
      "styles":"<xsl:apply-templates select="bfs:styles/gco:CharacterString" />",
      "format":"<xsl:apply-templates select="bfs:format/gco:CharacterString" />"
    },
  </xsl:template>


  <xsl:template match="bfs:MD_VectorLayerType">
    <xsl:variable name="host"><xsl:apply-templates select="bfs:URL/bfs:host/gco:CharacterString" /></xsl:variable>
    <xsl:variable name="path"><xsl:apply-templates select="bfs:URL/bfs:path/gco:CharacterString" /></xsl:variable>

    "vector":{
    "url":"<xsl:value-of select="concat(normalize-space($host),normalize-space($path))" />" ,
    "format":"<xsl:apply-templates select="bfs:format/gco:CharacterString" />",
    "params":"<xsl:apply-templates select="bfs:params/gco:CharacterString" />"
    },
  </xsl:template>

  <xsl:template match="bfs:MD_WMTSLayerType">
    <xsl:variable name="host"><xsl:apply-templates select="bfs:URL/bfs:host/gco:CharacterString" /></xsl:variable>
    <xsl:variable name="path"><xsl:apply-templates select="bfs:URL/bfs:path/gco:CharacterString" /></xsl:variable>

    "wmts":{
     "url":"<xsl:value-of select="concat(normalize-space($host),normalize-space($path))" />" ,
      "layers":"<xsl:apply-templates select="bfs:layer/gco:CharacterString" />",
      "tilematrixset":"<xsl:apply-templates select="bfs:tilematrixset/gco:CharacterString" />",
      "transparent":"<xsl:apply-templates select="bfs:transparent/gco:Boolean" />",
      "version":"<xsl:apply-templates select="bfs:version/gco:CharacterString" />",
      "styles":"<xsl:apply-templates select="bfs:styles/gco:CharacterString" />",
      "format":"<xsl:apply-templates select="bfs:format/gco:CharacterString" />"
    },
  </xsl:template>

  <xsl:template match="gco:Boolean">
    <xsl:choose>
      <xsl:when test=". = 'true'">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="gco:CharacterString" name="escapeJSON">
    <xsl:value-of select="util:encodeForJson(.)"/>
  </xsl:template>

  <xsl:template match="@*|node()">
      <xsl:apply-templates select="@*|node()[name(self::*)!='geonet:info']"/>
  </xsl:template>
</xsl:stylesheet>