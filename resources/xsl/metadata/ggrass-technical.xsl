<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:mods="http://www.loc.gov/mods/v3" xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions" xmlns:xalan="http://xml.apache.org/xalan"
  exclude-result-prefixes="i18n mods xlink mcrxsl xalan"
>

  <xsl:import href="xslImport:modsmeta:metadata/ggrass-technical.xsl" />

  <xsl:template match="/">

    <xsl:variable name="mods" select="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods" />
    <xsl:variable name="genre" select="substring-after(($mods/mods:genre[@type='kindof']|$mods/mods:genre[@type='intern'])[1]/@valueURI,'#')" />


    <div id="ggrass-technical-metadata">

      <div id="ggrass_recording">
        <div class="row">
          <div class="col-md-3 text-right">
            <xsl:value-of select="i18n:translate('ggrass.metaData.dictionary.recording')" />
          </div>
          <div class="col-md-9 ggrass_bborder">
            <br />
          </div>
        </div>

      <xsl:call-template name="printMetaDate.mods.ggrass">
        <xsl:with-param name="nodes" select="//mods:mods/mods:originInfo[@eventType='creation']/mods:dateCaptured[@encoding='w3cdtf']" />
        <xsl:with-param name="label" select="i18n:translate('ggrass.metaData.dictionary.dateCaptured')" />
      </xsl:call-template>

      <xsl:call-template name="printMetaDate.mods.ggrass">
        <xsl:with-param name="nodes" select="//mods:mods/mods:originInfo[@eventType='creation']/mods:dateIssued[@encoding='w3cdtf']" />
        <xsl:with-param name="label" select="i18n:translate('ggrass.metaData.dictionary.dateIssued')" />
      </xsl:call-template>

      <xsl:call-template name="printMetaDate.mods.ggrass">
        <xsl:with-param name="nodes" select="//mods:mods/mods:originInfo[@eventType='creation']/mods:dateIssued[not(@encoding)]" />
        <xsl:with-param name="label" select="i18n:translate('ggrass.metaData.dictionary.dateIssuedAddition')" />
      </xsl:call-template>

      <xsl:call-template name="printMetaDate.mods.ggrass">
        <xsl:with-param name="nodes" select="//mods:mods/mods:originInfo[@eventType='creation']/mods:place/mods:placeTerm[@type='text']" />
        <xsl:with-param name="label" select="i18n:translate('ggrass.metaData.dictionary.placeTerm')" />
      </xsl:call-template>

      <xsl:apply-templates mode="ggrass" select="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:classification[@authorityURI='http://webdatenbank.grass-medienarchiv.de/classifications/Sprachen']" />
      <xsl:apply-templates mode="ggrass" select="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:classification[@authorityURI='http://webdatenbank.grass-medienarchiv.de/classifications/Betriebsarten']" />

      <xsl:call-template name="printMetaDate.mods.ggrass">
        <xsl:with-param name="nodes" select="//mods:mods/mods:note[@type='quality']" />
        <xsl:with-param name="label" select="i18n:translate('ggrass.metaData.dictionary.note.quality')" />
      </xsl:call-template>

      </div>

      <div id="ggrass_original">
        <div class="row">
          <div class="col-md-3 text-right">
            <xsl:value-of select="i18n:translate('ggrass.metaData.dictionary.original')" />
          </div>
          <div class="col-md-9 ggrass_bborder">
            <br />
          </div>
        </div>

        <!-- TODO -->
      </div>


      <div id="ggrass_copy">
        <div class="row">
          <div class="col-md-3 text-right">
            <xsl:value-of select="i18n:translate('ggrass.metaData.dictionary.copy')" />
          </div>
          <div class="col-md-9 ggrass_bborder">
            <br />
          </div>
        </div>

        <!-- TODO -->
      </div>
    </div>

    <div id="ggrass_origin">
        <div class="row">
          <div class="col-md-3 text-right">
            <xsl:value-of select="i18n:translate('ggrass.metaData.dictionary.origin')" />
          </div>
          <div class="col-md-9 ggrass_bborder">
            <br />
          </div>
        </div>

        <!-- TODO -->
      </div>
    </div>

    <xsl:apply-imports />
  </xsl:template>


</xsl:stylesheet>