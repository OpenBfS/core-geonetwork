<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:bfs="http://geonetwork.org/bfs"
                xmlns:gmd="http://www.isotc211.org/2005/gmd" version="2.0">

    <xsl:template match="bfs:MD_Metadata">
        <dateStamp><xsl:value-of select="gmd:dateStamp/*"/></dateStamp>
    </xsl:template>

</xsl:stylesheet>