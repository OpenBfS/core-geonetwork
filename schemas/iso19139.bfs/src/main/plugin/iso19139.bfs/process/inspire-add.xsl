<?xml version="1.0" encoding="UTF-8"?>
<!--  
Stylesheet used to update metadata adding a reference to a parent record.
-->
<xsl:stylesheet version="2.0" xmlns:gmd="http://www.isotc211.org/2005/gmd"
								xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:gts="http://www.isotc211.org/2005/gts"
								xmlns:gml="http://www.opengis.net/gml" xmlns:srv="http://www.isotc211.org/2005/srv"
								xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:bfs="http://geonetwork.org/bfs"
								xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:geonet="http://www.fao.org/geonetwork">

	<!-- Parent metadata record UUID -->
	<xsl:param name="inspireUuid"/>

	<xsl:template match="bfs:MD_Layer">
		<xsl:copy>
			<xsl:copy-of select="@*"/>


			<!-- Only one parent identifier allowed
			- overwriting existing one. -->
			<bfs:inspireID>
				<gco:CharacterString>
					<xsl:value-of select="$inspireUuid"/>
				</gco:CharacterString>
			</bfs:inspireID>

			<xsl:copy-of
				select="
			bfs:layerType|
			bfs:wfs|
			bfs:download|
			bfs:filter|
			bfs:olProperty"/>

		</xsl:copy>
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
