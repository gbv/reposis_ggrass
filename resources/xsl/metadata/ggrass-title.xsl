<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:mods="http://www.loc.gov/mods/v3" xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions" xmlns:xalan="http://xml.apache.org/xalan"
  exclude-result-prefixes="i18n mods xlink mcrxsl xalan"
>

  <xsl:import href="xslImport:modsmeta:metadata/ggrass-title.xsl" />

  <xsl:template match="/">

    <xsl:variable name="mods" select="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods" />
    <xsl:variable name="genre" select="($mods/mods:genre[@type='kindof']|$mods/mods:genre[@type='intern'])[1]" />

    <!-- headline -->
    <div id="ggrass-title">
      <div class="row">
        <div class="col-md-3" id="ggrass_databaseID">
          DB-Nummer:
          <xsl:value-of select="substring-after(mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:identifier[@type='intern'], 'DBNummerNeu: ')" />
          <xsl:choose>
            <xsl:when test="$genre='audio'">
              <img id="ggrass_media_icon" src="{$WebApplicationBaseURL}images/audio_icon_metadata.png" />
            </xsl:when>
            <xsl:when test="$genre='video'">
              <img id="ggrass_media_icon" src="{$WebApplicationBaseURL}images/video_icon_metadata.png" />
            </xsl:when>
          </xsl:choose>

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

    <xsl:apply-imports />
  </xsl:template>

</xsl:stylesheet>