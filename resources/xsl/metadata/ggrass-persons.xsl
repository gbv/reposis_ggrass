<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:mods="http://www.loc.gov/mods/v3" xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions" xmlns:xalan="http://xml.apache.org/xalan"
  exclude-result-prefixes="i18n mods xlink mcrxsl xalan"
>

  <xsl:import href="xslImport:modsmeta:metadata/ggrass-persons.xsl" />
  <xsl:include href="ggrass-utils.xsl" />

  <xsl:template match="/">

    <xsl:variable name="mods" select="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods" />

    <div id="ggrass-persons-metadata">

      <div class="ggrass_content_block" id="ggrass_persons">
        <div class="row">
          <div class="col-md-3 text-right">
            <xsl:value-of select="i18n:translate('ggrass.metaData.dictionary.persons')" />
          </div>
          <div class="col-md-9">
            <hr class="ggrass_hr" />
          </div>
        </div>

      </div>

      <div class="ggrass_content_block" id="ggrass_refer">
        <div class="row">
          <div class="col-md-3 text-right">
            <xsl:value-of select="i18n:translate('ggrass.metaData.dictionary.refer')" />
          </div>
          <div class="col-md-9">
            <hr class="ggrass_hr" />
          </div>
        </div>

      </div>

    </div>

    <xsl:apply-imports />
  </xsl:template>


</xsl:stylesheet>