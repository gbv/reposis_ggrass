<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:mods="http://www.loc.gov/mods/v3" xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions" xmlns:xalan="http://xml.apache.org/xalan"
  exclude-result-prefixes="i18n mods xlink mcrxsl xalan"
>

  <xsl:template match="mods:classification" mode="ggrass">
    <div class="row">
      <div class="col-md-3 text-right">
        <xsl:choose>
          <xsl:when test="not(contains(i18n:translate(concat('component.mods.metaData.dictionary.', @displayLabel)), 'component.mods.metaData.dictionary.'))">
            <xsl:value-of select="concat(i18n:translate(concat('component.mods.metaData.dictionary.', @displayLabel)), ':')" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat(i18n:translate('component.mods.metaData.dictionary.classification'), ':')" />
          </xsl:otherwise>
        </xsl:choose>
        </div>
        <div class="col-md-9">
          <xsl:apply-templates select="." mode="printModsClassInfo" />
        </div>
      </div>
  </xsl:template>


  <xsl:template name="printMetaDate.mods.ggrass">
    <!-- prints a table row for a given nodeset -->
    <xsl:param name="nodes" />
    <xsl:param name="label" select="i18n:translate(concat('component.mods.metaData.dictionary.',local-name($nodes[1])))" />
    <xsl:param name="sep" select="''" />
    <xsl:param name="property" select="''" />
    <xsl:message>
      <xsl:value-of select="concat('label: ',$label)" />
    </xsl:message>
    <xsl:message>
      <xsl:value-of select="concat('nodes: ',count($nodes))" />
    </xsl:message>
    <xsl:if test="$nodes">
      <div class="row">
        <div class="col-md-3 text-right">
          <xsl:value-of select="concat($label,':')" />
        </div>
        <div class="col-md-9">
          <xsl:if test="$property != ''">
            <xsl:attribute name="property">
              <xsl:value-of select="$property" />
            </xsl:attribute>
          </xsl:if>
          <xsl:variable name="selectPresentLang">
            <xsl:call-template name="selectPresentLang">
              <xsl:with-param name="nodes" select="$nodes" />
            </xsl:call-template>
          </xsl:variable>
          <xsl:for-each select="$nodes">
            <xsl:if test="position()!=1">
              <xsl:choose>
                <xsl:when test="string-length($sep)&gt;0">
                  <xsl:value-of select="$sep" />
                </xsl:when>
                <xsl:otherwise>
                  <br />
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
            <xsl:choose>
              <xsl:when test="mods:dateCreated|mods:dateOther|mods:dateIssued|mods:dateCaptured|mods:dateModified">
                <xsl:apply-templates select="." mode="rangeDate"/>
              </xsl:when>
              <xsl:when test="not(@xml:lang) or @xml:lang=$selectPresentLang">
                <xsl:call-template name="lf2br">
                  <xsl:with-param name="string" select="normalize-space(.)" />
                </xsl:call-template>
              </xsl:when>
            </xsl:choose>
          </xsl:for-each>
        </div>
      </div>
    </xsl:if>
  </xsl:template>


</xsl:stylesheet>