<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:mods="http://www.loc.gov/mods/v3" xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions" xmlns:xalan="http://xml.apache.org/xalan"
  exclude-result-prefixes="i18n mods xlink mcrxsl xalan"
>

  <xsl:import href="xslImport:modsmeta:metadata/ggrass-title.xsl" />

  <xsl:template match="/">

    <xsl:variable name="mods" select="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods" />
    <xsl:variable name="genre" select="substring-after(($mods/mods:genre[@type='kindof']|$mods/mods:genre[@type='intern'])[1]/@valueURI,'#')" />

    <!-- headline -->
    <div id="ggrass-title">
      <div class="row">
        <div class="col-md-3" id="ggrass_databaseID">
          DB-Nummer:
          <xsl:value-of select="substring-after(mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:identifier[@type='intern'], 'DBNummerNeu: ')" />
        </div>
        <div class="col-md-9">
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

    <div id="ggrass-title-metadata">
      <div class="row">
        <div class="col-md-3 text-right">
          <xsl:value-of select="i18n:translate('ggrass.metaData.dictionary.origTitle')" />
        </div>
        <div class="col-md-9">
          <xsl:apply-templates mode="mods.title" select="$mods">
            <xsl:with-param name="asHTML" select="true()" />
            <xsl:with-param name="withSubtitle" select="true()" />
          </xsl:apply-templates>
        </div>
      </div>

      <!-- Anfang/Ende -->

      <xsl:apply-templates mode="ggrass" select="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:classification[@authorityURI='http://webdatenbank.grass-medienarchiv.de/classifications/GenreInhalt']" />
      <xsl:apply-templates mode="ggrass" select="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:classification[@authorityURI='http://webdatenbank.grass-medienarchiv.de/classifications/Praesentation']" />

      <!-- historischer Kontext -->

      <div class="ggrass_bborder" id="ggrass_subject">
        <div class="row">
          <div class="col-md-3 text-right">
            <xsl:value-of select="i18n:translate('ggrass.metaData.dictionary.subject')" />
          </div>
          <div class="col-md-9 ggrass_bborder">
            <br />
          </div>
        </div>

        <xsl:call-template name="printMetaDate.mods.ggrass">
          <xsl:with-param name="nodes" select="//mods:mods/mods:subject/mods:name[@type='personal']" />
          <xsl:with-param name="label" select="i18n:translate('ggrass.metaData.dictionary.subject.Persons')" />
          <xsl:with-param name="sep" select="'; '" />
          <xsl:with-param name="property" select="'keyword'" />
        </xsl:call-template>


        <xsl:call-template name="printMetaDate.mods.ggrass">
          <xsl:with-param name="nodes" select="//mods:mods/mods:subject/mods:titleInfo[@authorityURI='http://webdatenbank.grass-medienarchiv.de/classifications/SWWerke']/mods:title" />
          <xsl:with-param name="label" select="i18n:translate('ggrass.metaData.dictionary.subject.SWWerke')" />
          <xsl:with-param name="sep" select="'; '" />
          <xsl:with-param name="property" select="'keyword'" />
        </xsl:call-template>

        <xsl:call-template name="printMetaDate.mods.ggrass">
          <xsl:with-param name="nodes" select="//mods:mods/mods:subject/mods:topic[@authorityURI='http://webdatenbank.grass-medienarchiv.de/classifications/SWSach']" />
          <xsl:with-param name="label" select="i18n:translate('ggrass.metaData.dictionary.subject.SWSach')" />
          <xsl:with-param name="sep" select="'; '" />
          <xsl:with-param name="property" select="'keyword'" />
        </xsl:call-template>

        <xsl:call-template name="printMetaDate.mods.ggrass">
          <xsl:with-param name="nodes" select="//mods:mods/mods:subject/mods:geographic[@authorityURI='http://webdatenbank.grass-medienarchiv.de/classifications/GeoDaten']" />
          <xsl:with-param name="label" select="i18n:translate('ggrass.metaData.dictionary.subject.GeoDaten')" />
          <xsl:with-param name="sep" select="'; '" />
          <xsl:with-param name="property" select="'keyword'" />
        </xsl:call-template>

        <xsl:call-template name="printMetaDate.mods.ggrass">
          <xsl:with-param name="nodes" select="//mods:mods/mods:subject/mods:temporal[@authorityURI='http://webdatenbank.grass-medienarchiv.de/classifications/SWZeit']" />
          <xsl:with-param name="label" select="i18n:translate('ggrass.metaData.dictionary.subject.SWZeit')" />
          <xsl:with-param name="sep" select="'; '" />
          <xsl:with-param name="property" select="'keyword'" />
        </xsl:call-template>
      </div>
    </div>

    <xsl:apply-imports />
  </xsl:template>



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
            <xsl:if test="not(@xml:lang) or @xml:lang=$selectPresentLang">
              <xsl:call-template name="lf2br">
                <xsl:with-param name="string" select="normalize-space(.)" />
              </xsl:call-template>
            </xsl:if>
          </xsl:for-each>
        </div>
      </div>
    </xsl:if>
  </xsl:template>


</xsl:stylesheet>