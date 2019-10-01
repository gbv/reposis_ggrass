<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:mods="http://www.loc.gov/mods/v3" xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions" xmlns:xalan="http://xml.apache.org/xalan"
  exclude-result-prefixes="i18n mods xlink mcrxsl xalan"
>

  <xsl:import href="xslImport:modsmeta:metadata/ggrass-notes.xsl" />
  <xsl:include href="ggrass-utils.xsl" />

  <xsl:template match="/">

    <xsl:variable name="mods" select="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods" />

    <div id="ggrass-notes-metadata">

      <xsl:if test="$mods/mods:note">
        <div class="ggrass_content_block" id="ggrass_notes">
          <div class="row">
            <div class="col-md-3 text-right">
              <xsl:value-of select="i18n:translate('ggrass.metaData.dictionary.notes')" />
            </div>
            <div class="col-md-9">
              <hr class="ggrass_hr" />
            </div>
          </div>

          <xsl:if test="$mods/mods:note[@type='content']">
            <div class="row">
              <div class="col-md-3 text-right">
                <xsl:value-of select="i18n:translate('ggrass.metaData.dictionary.notes.content')" />
              </div>
              <div class="col-md-9">
                <xsl:value-of select="$mods/mods:note[@type='content']" />
              </div>
            </div>
          </xsl:if>

          <xsl:if test="$mods/mods:note[@type='user']">
            <div class="row">
              <div class="col-md-3 text-right">
                <xsl:value-of select="i18n:translate('ggrass.metaData.dictionary.notes.user')" />
              </div>
              <div class="col-md-9">
                <xsl:value-of select="$mods/mods:note[@type='user']" />
              </div>
            </div>
          </xsl:if>

          <xsl:if test="$mods/mods:note[@type='mcr_intern'] and not(mcrxsl:isCurrentUserGuestUser())">
            <div class="row">
              <div class="col-md-3 text-right">
                <xsl:value-of select="i18n:translate('ggrass.metaData.dictionary.notes.mcr_intern')" />
              </div>
              <div class="col-md-9">
                <xsl:value-of select="$mods/mods:note[@type='mcr_intern']" />
              </div>
            </div>
          </xsl:if>

        </div>
      </xsl:if>

    </div>

    <xsl:apply-imports />
  </xsl:template>


</xsl:stylesheet>