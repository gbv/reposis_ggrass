<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:mods="http://www.loc.gov/mods/v3" xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions" xmlns:xalan="http://xml.apache.org/xalan"
  exclude-result-prefixes="i18n mods xlink mcrxsl xalan"
>

  <xsl:import href="xslImport:modsmeta:metadata/ggrass-title.xsl" />

  <xsl:template match="/">

    <xsl:variable name="mods" select="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods" />

    <!-- badges -->
    <div id="mir-abstract-badges">
      <xsl:variable name="dateIssued">
        <xsl:apply-templates mode="mods.datePublished" select="$mods" />
      </xsl:variable>

        <!-- TODO: Update badges -->
      <div id="badges">
        <xsl:call-template name="categorySearchLink">
          <xsl:with-param name="class" select="'mods_genre label label-info'" />
          <xsl:with-param name="node" select="($mods/mods:genre[@type='kindof']|$mods/mods:genre[@type='intern'])[1]" />
        </xsl:call-template>

        <xsl:if test="string-length($dateIssued) > 0">
          <time itemprop="datePublished" datetime="{$dateIssued}" data-toggle="tooltip" title="Publication date">
            <span class="date_published label label-primary">
              <xsl:variable name="format">
                <xsl:choose>
                  <xsl:when test="string-length(normalize-space($dateIssued))=4">
                    <xsl:value-of select="i18n:translate('metaData.dateYear')" />
                  </xsl:when>
                  <xsl:when test="string-length(normalize-space($dateIssued))=7">
                    <xsl:value-of select="i18n:translate('metaData.dateYearMonth')" />
                  </xsl:when>
                  <xsl:when test="string-length(normalize-space($dateIssued))=10">
                    <xsl:value-of select="i18n:translate('metaData.dateYearMonthDay')" />
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="i18n:translate('metaData.dateTime')" />
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:variable>
              <xsl:call-template name="formatISODate">
                <xsl:with-param name="date" select="$dateIssued" />
                <xsl:with-param name="format" select="$format" />
              </xsl:call-template>
            </span>
          </time>
        </xsl:if>

        <xsl:variable name="accessCondition" select="substring-after(normalize-space($mods/mods:accessCondition[@type='use and reproduction']/@xlink:href),'#')" />
        <xsl:if test="$accessCondition">
          <xsl:variable name="linkText">
            <xsl:choose>
              <xsl:when test="contains($accessCondition, 'rights_reserved')">
                <xsl:value-of select="i18n:translate('component.mods.metaData.dictionary.rightsReserved')" />
              </xsl:when>
              <xsl:when test="contains($accessCondition, 'oa_nlz')">
                <xsl:value-of select="i18n:translate('component.mods.metaData.dictionary.oa_nlz.short')" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="mcrxsl:getDisplayName('mir_licenses',$accessCondition)" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:call-template name="searchLink">
            <xsl:with-param name="class" select="'access_condition label label-success'" />
            <xsl:with-param name="linkText" select="$linkText" />
            <xsl:with-param name="query" select="concat('%2BallMeta%3A&quot;',$accessCondition,'&quot;')" />
          </xsl:call-template>
        </xsl:if>
      </div><!-- end: badges -->
    </div><!-- end: badgets structure -->

    <!-- headline -->
    <div id="ggrass-title">
      <div class="row">
        <div class="col-md-2">
          DB-Nummer: 667
        </div>
        <div class="col-md-10">
          <h1 itemprop="name">
            <xsl:apply-templates mode="mods.title" select="$mods">
              <xsl:with-param name="type" select="'alternative'" />
              <xsl:with-param name="asHTML" select="true()" />
              <xsl:with-param name="withSubtitle" select="true()" />
            </xsl:apply-templates>
          </h1>
        </div>
      </div>
    </div>

    <xsl:apply-imports />
  </xsl:template>

</xsl:stylesheet>