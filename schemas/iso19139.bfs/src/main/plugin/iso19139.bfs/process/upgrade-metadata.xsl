<?xml version="1.0" encoding="UTF-8"?>
<!--
Stylesheet used to upgrade legacy bfs metadata.
-->
<xsl:stylesheet version="2.0"
                xmlns:gmd="http://www.isotc211.org/2005/gmd"
                xmlns:geonet="http://www.fao.org/geonetwork"
                xmlns:bfs="http://geonetwork.org/bfs"
                xmlns:gco="http://www.isotc211.org/2005/gco"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="#all">

  <!-- ============================================================================= -->

  <!-- MD_VectorLayerType: don't copy the styles, removed in latest version -->
  <xsl:template match="bfs:MD_VectorLayerType">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates select="bfs:URL" />
      <xsl:apply-templates select="bfs:format" />
      <xsl:apply-templates select="bfs:params" />
    </xsl:copy>
  </xsl:template>


  <!-- MD_PointInTimeFilter -->
  <xsl:template match="bfs:MD_PointInTimeFilter">
    <xsl:copy>
      <xsl:copy-of select="@*"/>

      <xsl:apply-templates select="bfs:paramName" />

      <xsl:choose>
        <xsl:when test="bfs:interval">
          <xsl:apply-templates select="bfs:interval" />

        </xsl:when>
        <xsl:otherwise>
          <bfs:interval>
            <gco:Integer></gco:Integer>
          </bfs:interval>
        </xsl:otherwise>
      </xsl:choose>


      <xsl:choose>
        <xsl:when test="bfs:unit">
          <xsl:apply-templates select="bfs:unit" />
        </xsl:when>
        <xsl:otherwise>
          <bfs:unit gco:nilReason="missing">
            <gco:CharacterString/>
          </bfs:unit>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:choose>
        <xsl:when test="bfs:minDate">
          <xsl:apply-templates select="bfs:minDate" />
        </xsl:when>
        <xsl:otherwise>
          <bfs:minDate>
            <bfs:TimeFormat>
              <gco:CharacterString><xsl:value-of select="bfs:date/bfs:TimeFormat/gco:CharacterString" /></gco:CharacterString>
            </bfs:TimeFormat>
            <bfs:TimeInstant>
              <gco:CharacterString><xsl:value-of select="bfs:date/bfs:TimeInstant/gco:DateTime" /></gco:CharacterString>
            </bfs:TimeInstant>
          </bfs:minDate>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:choose>
        <xsl:when test="bfs:maxDate">
          <xsl:apply-templates select="bfs:maxDate" />
        </xsl:when>
        <xsl:otherwise>
          <bfs:maxDate>
            <bfs:TimeFormat gco:nilReason="missing">
              <gco:CharacterString/>
            </bfs:TimeFormat>
            <bfs:TimeInstant gco:nilReason="missing">
              <gco:CharacterString/>
            </bfs:TimeInstant>
          </bfs:maxDate>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:choose>
        <xsl:when test="bfs:defaultValue">
          <xsl:apply-templates select="bfs:defaultValue" />
        </xsl:when>
        <xsl:otherwise>
          <bfs:defaultValue>
            <bfs:TimeFormat gco:nilReason="missing">
              <gco:CharacterString/>
            </bfs:TimeFormat>
            <bfs:TimeInstant gco:nilReason="missing">
              <gco:CharacterString/>
            </bfs:TimeInstant>
          </bfs:defaultValue>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>

  <!-- MD_TimeRangeFilter -->
  <xsl:template match="bfs:MD_TimeRangeFilter">
    <xsl:copy>
      <xsl:copy-of select="@*"/>

      <xsl:apply-templates select="bfs:paramName" />

      <xsl:choose>
        <xsl:when test="bfs:interval">
          <xsl:apply-templates select="bfs:interval" />

        </xsl:when>
        <xsl:otherwise>
          <bfs:interval>
            <gco:Integer></gco:Integer>
          </bfs:interval>
        </xsl:otherwise>
      </xsl:choose>


      <xsl:choose>
        <xsl:when test="bfs:unit">
          <xsl:apply-templates select="bfs:unit" />
        </xsl:when>
        <xsl:otherwise>
          <bfs:unit gco:nilReason="missing">
            <gco:CharacterString/>
          </bfs:unit>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:choose>
        <xsl:when test="bfs:maxDuration">
          <xsl:apply-templates select="bfs:maxDuration" />
        </xsl:when>
        <xsl:otherwise>
          <bfs:maxDuration gco:nilReason="missing">
            <gco:CharacterString/>
          </bfs:maxDuration>
        </xsl:otherwise>
      </xsl:choose>


      <xsl:choose>
        <xsl:when test="bfs:minDate">
          <xsl:apply-templates select="bfs:minDate" />
        </xsl:when>
        <xsl:otherwise>
          <bfs:minDate>
            <bfs:TimeFormat>
              <gco:CharacterString><xsl:value-of select="bfs:date/bfs:TimeFormat/gco:CharacterString" /></gco:CharacterString>
            </bfs:TimeFormat>
            <bfs:TimeInstant>
              <gco:CharacterString><xsl:value-of select="bfs:date/bfs:TimeInstant/gco:DateTime" /></gco:CharacterString>
            </bfs:TimeInstant>
          </bfs:minDate>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:choose>
        <xsl:when test="bfs:maxDate">
          <xsl:apply-templates select="bfs:maxDate" />
        </xsl:when>
        <xsl:otherwise>
          <bfs:maxDate>
            <bfs:TimeFormat gco:nilReason="missing">
              <gco:CharacterString/>
            </bfs:TimeFormat>
            <bfs:TimeInstant gco:nilReason="missing">
              <gco:CharacterString/>
            </bfs:TimeInstant>
          </bfs:maxDate>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:choose>
      <xsl:when test="bfs:defaultStartValue">
        <xsl:apply-templates select="bfs:defaultStartValue" />
      </xsl:when>
      <xsl:otherwise>
        <bfs:defaultStartValue>
          <bfs:TimeFormat gco:nilReason="missing">
            <gco:CharacterString/>
          </bfs:TimeFormat>
          <bfs:TimeInstant gco:nilReason="missing">
            <gco:CharacterString/>
          </bfs:TimeInstant>
        </bfs:defaultStartValue>
      </xsl:otherwise>
    </xsl:choose>

      <xsl:choose>
        <xsl:when test="bfs:defaultEndValue">
          <xsl:apply-templates select="bfs:defaultEndValue" />
        </xsl:when>
        <xsl:otherwise>
          <bfs:defaultEndValue>
            <bfs:TimeFormat gco:nilReason="missing">
              <gco:CharacterString/>
            </bfs:TimeFormat>
            <bfs:TimeInstant gco:nilReason="missing">
              <gco:CharacterString/>
            </bfs:TimeInstant>
          </bfs:defaultEndValue>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>


  <!-- MD_ValueFilter -->
  <xsl:template match="bfs:MD_ValueFilter">
    <xsl:copy>
      <xsl:copy-of select="@*"/>

      <xsl:apply-templates select="bfs:paramName" />

      <xsl:choose>
        <xsl:when test="bfs:paramAlias">
          <xsl:apply-templates select="bfs:paramAlias" />
        </xsl:when>
        <xsl:otherwise>
          <bfs:paramAlias gco:nilReason="missing">
          <gco:CharacterString/>
          </bfs:paramAlias>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:choose>
        <xsl:when test="bfs:defaultValue">
          <xsl:apply-templates select="bfs:defaultValue" />

        </xsl:when>
        <xsl:otherwise>
          <bfs:defaultValue gco:nilReason="missing">
            <gco:CharacterString/>
          </bfs:defaultValue>
        </xsl:otherwise>
      </xsl:choose>


      <xsl:choose>
        <xsl:when test="bfs:allowedValues">
          <xsl:apply-templates select="bfs:allowedValues" />
        </xsl:when>
        <xsl:otherwise>
          <bfs:allowedValues gco:nilReason="missing">
            <gco:CharacterString/>
          </bfs:allowedValues>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:choose>
        <xsl:when test="bfs:operator">
          <xsl:apply-templates select="bfs:operator" />
        </xsl:when>
        <xsl:otherwise>
          <bfs:operator gco:nilReason="missing">
            <gco:CharacterString/>
          </bfs:operator>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:choose>
        <xsl:when test="bfs:allowMultipleSelect">
          <xsl:apply-templates select="bfs:allowMultipleSelect" />
        </xsl:when>
        <xsl:otherwise>
          <bfs:allowMultipleSelect>
            <gco:Boolean>false</gco:Boolean>
          </bfs:allowMultipleSelect>
        </xsl:otherwise>
      </xsl:choose>

    </xsl:copy>
  </xsl:template>

  <!-- TimeInstant -->
  <xsl:template match="bfs:TimeInstant">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      
      <xsl:choose>
        <xsl:when test="gco:DateTime">
          <gco:CharacterString><xsl:value-of select="gco:DateTime" /></gco:CharacterString>
        </xsl:when>
        <xsl:when test="gco:Date">
          <gco:CharacterString><xsl:value-of select="gco:Date" /></gco:CharacterString>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="gco:CharacterString" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>

  <!-- download -->
  <xsl:template match="bfs:download">
    <xsl:copy>
      <xsl:copy-of select="@*" />

      <xsl:apply-templates select="bfs:URL" />

      <xsl:choose>
        <xsl:when test="bfs:placeholderStart">
          <xsl:apply-templates select="bfs:placeholderStart" />
        </xsl:when>
        <xsl:otherwise>
          <bfs:filterFieldStart gco:nilReason="missing">
            <gco:CharacterString/>
          </bfs:filterFieldStart>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:choose>
        <xsl:when test="bfs:placeholderEnd">
          <xsl:apply-templates select="bfs:placeholderEnd" />
        </xsl:when>
        <xsl:otherwise>
          <bfs:filterFieldEnd gco:nilReason="missing">
            <gco:CharacterString/>
          </bfs:filterFieldEnd>
        </xsl:otherwise>
      </xsl:choose>

    </xsl:copy>
  </xsl:template>

  <!-- placeholderStart translated to filterFieldStart -->
  <xsl:template match="bfs:placeholderStart">
    <bfs:filterFieldStart>
      <gco:CharacterString><xsl:value-of select="*" /></gco:CharacterString>
    </bfs:filterFieldStart>
  </xsl:template>

  <!-- placeholderEnd translated to filterFieldEnd -->
  <xsl:template match="bfs:placeholderEnd">
    <bfs:filterFieldEnd>
      <gco:CharacterString><xsl:value-of select="*" /></gco:CharacterString>
    </bfs:filterFieldEnd>
  </xsl:template>

  <!-- Do a copy of every nodes and attributes -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Remove geonet:* elements. -->
  <xsl:template match="geonet:*" priority="2"/>
</xsl:stylesheet>
