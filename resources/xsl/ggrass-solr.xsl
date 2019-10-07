<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mods="http://www.loc.gov/mods/v3"
  xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  exclude-result-prefixes="mods mcrxsl xlink"
>
  <xsl:import href="xslImport:solr-document:ggrass-solr.xsl" />

  <xsl:template match="mycoreobject[contains(@ID,'_mods_')]">
    <xsl:apply-imports />
    <!-- fields from mycore-mods -->
    <!-- xsl:apply-templates select="metadata/def.modsContainer/modsContainer/mods:mods" mode="ggrass" / -->
  </xsl:template>

  <xsl:template priority="10" mode="resulttitle" match="mycoreobject[contains(@ID,'_mods_')]">
    <xsl:variable name="completeTitle">
      <xsl:choose>
        <xsl:when test="//mods:mods/mods:title[not(@type)]">
          <xsl:apply-templates select="./metadata/def.modsContainer/modsContainer/mods:mods" mode="mods.title" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates mode="mods.title" select="$mods">
            <xsl:with-param name="type" select="'alternative'" />
            <xsl:with-param name="asHTML" select="false()" />
            <xsl:with-param name="withSubtitle" select="true()" />
          </xsl:apply-templates>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:value-of select="mcrxml:shortenText($completeTitle, 70)" />
  </xsl:template>
  
</xsl:stylesheet>