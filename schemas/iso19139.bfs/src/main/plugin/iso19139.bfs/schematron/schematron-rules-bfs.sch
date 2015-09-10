<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
            xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <sch:title xmlns="http://www.w3.org/2001/XMLSchema">Schematron validation / Bfs rules</sch:title>
  <sch:ns prefix="gml" uri="http://www.opengis.net/gml"/>
  <sch:ns prefix="gmd" uri="http://www.isotc211.org/2005/gmd"/>
  <sch:ns prefix="srv" uri="http://www.isotc211.org/2005/srv"/>
  <sch:ns prefix="gco" uri="http://www.isotc211.org/2005/gco"/>
  <sch:ns prefix="geonet" uri="http://www.fao.org/geonetwork"/>
  <sch:ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>
  <sch:ns prefix="bfs" uri="http://geonetwork.org/bfs" />

  <!-- =============================================================
  Bfs schematron rules:
  ============================================================= -->

  <sch:pattern>
    <sch:rule context="bfs:olProperty">
      <sch:let name="val" value="bfs:MD_Property/bfs:propertyName/gco:CharacterString" />

      <sch:assert test="count(preceding-sibling::bfs:olProperty[bfs:MD_Property/bfs:propertyName/gco:CharacterString = $val]) = 0">
        Duplicated OL Property with name '<sch:value-of select="$val"/>'.
      </sch:assert>
    </sch:rule>

    <sch:rule context="bfs:timeSeriesChartProperty">
      <sch:let name="val" value="bfs:MD_Property/bfs:propertyName/gco:CharacterString" />

      <sch:assert test="count(preceding-sibling::bfs:timeSeriesChartProperty[bfs:MD_Property/bfs:propertyName/gco:CharacterString = $val]) = 0">
        Duplicated Time Series Chart Property with name '<sch:value-of select="$val"/>'.
      </sch:assert>
    </sch:rule>

    <sch:rule context="bfs:barChartProperty">
      <sch:let name="val" value="bfs:MD_Property/bfs:propertyName/gco:CharacterString" />

      <sch:assert test="count(preceding-sibling::bfs:barChartProperty[bfs:MD_Property/bfs:propertyName/gco:CharacterString = $val]) = 0">
        Duplicated Bar Chart Property with name '<sch:value-of select="$val"/>'.
      </sch:assert>
    </sch:rule>
  </sch:pattern>

</sch:schema>
