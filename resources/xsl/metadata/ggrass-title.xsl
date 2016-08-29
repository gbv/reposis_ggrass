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

    </div>

    <div id="ggrass_subjects">
      <div class="row">
        <div class="col-md-3 text-right">
          <xsl:value-of select="i18n:translate('ggrass.metaData.dictionary.subject')" />
        </div>
        <div class="col-md-9 ggrass_bborder">
          <br />
        </div>
      </div>

      <!-- Personen -->

      <xsl:apply-templates mode="ggrass" select="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:classification[@authorityURI='http://webdatenbank.grass-medienarchiv.de/classifications/SWWerke']" />
      <xsl:apply-templates mode="ggrass" select="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:classification[@authorityURI='http://webdatenbank.grass-medienarchiv.de/classifications/SWSach']" />
      <xsl:apply-templates mode="ggrass" select="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:classification[@authorityURI='http://webdatenbank.grass-medienarchiv.de/classifications/GeoDaten']" />
      <xsl:apply-templates mode="ggrass" select="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:classification[@authorityURI='http://webdatenbank.grass-medienarchiv.de/classifications/SWZeit']" />

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

</xsl:stylesheet>