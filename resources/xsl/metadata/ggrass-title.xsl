<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:mods="http://www.loc.gov/mods/v3" xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions" xmlns:xalan="http://xml.apache.org/xalan"
  exclude-result-prefixes="i18n mods xlink mcrxsl xalan"
>

  <xsl:import href="xslImport:modsmeta:metadata/ggrass-title.xsl" />
  <xsl:include href="ggrass-utils.xsl" />

  <xsl:template match="/">

    <xsl:variable name="mods" select="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods" />
    <xsl:variable name="genre" select="substring-after(($mods/mods:genre[@type='kindof']|$mods/mods:genre[@type='intern'])[1]/@valueURI,'#')" />

    <!-- headline -->
    <div id="ggrass-title">
      <div class="row">
        <div class="col-md-3" id="ggrass_databaseID">
          DB-Nummer:
          <xsl:value-of select="substring-after(mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:identifier[@type='intern'], 'DBNummerNeu: ')" />
          <xsl:if test="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:identifier[@type='doi']">
            <br />
            <a href="http://dx.doi.org/{mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:identifier[@type='doi']}">
              <xsl:value-of select="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:identifier[@type='doi']" />
            </a>
          </xsl:if>
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

      <xsl:call-template name="printMetaDate.mods.ggrass">
        <xsl:with-param name="nodes" select="//mods:mods/mods:note[@type='start_end']" />
        <xsl:with-param name="label" select="i18n:translate('ggrass.metaData.dictionary.note.start_end')" />
      </xsl:call-template>

      <xsl:apply-templates mode="ggrass" select="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:classification[@authorityURI='http://webdatenbank.grass-medienarchiv.de/classifications/GenreInhalt']" />
      <xsl:apply-templates mode="ggrass" select="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:classification[@authorityURI='http://webdatenbank.grass-medienarchiv.de/classifications/Praesentation']" />

      <xsl:if test="//mods:mods/mods:note[@type='context']">
        <div class="row">
          <div class="col-md-3 text-right">
            <xsl:value-of select="i18n:translate('ggrass.metaData.dictionary.note.context')" />
          </div>
          <div class="col-md-9">
            <div style="word-wrap: break-word;" class="ellipsis ellipsis-text is-truncated">
              <p style="display: block;">
                <xsl:apply-templates select="//mods:mods/mods:note[@type='context']" mode="copyNode" />
                <a href="#" class="readless hidden" title="read less">
                  <xsl:value-of select="i18n:translate('mir.abstract.readless')" />
                </a>
                <a href="#" class="readmore hidden" title="read more">
                  <xsl:value-of select="i18n:translate('mir.abstract.readmore')" />
                </a>
              </p>
            </div>
          </div>
        </div>
      </xsl:if>


      <div class="ggrass_content_block" id="ggrass_subject">
        <div class="row">
          <div class="col-md-3 text-right">
            <xsl:value-of select="i18n:translate('ggrass.metaData.dictionary.subject')" />
          </div>
          <div class="col-md-9">
            <hr class="ggrass_hr" />
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

</xsl:stylesheet>