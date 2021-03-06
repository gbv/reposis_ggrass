<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:mods="http://www.loc.gov/mods/v3" xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions"
  xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation" xmlns:ex="http://exslt.org/dates-and-times" exclude-result-prefixes="mods mcrxsl i18n ex"
>
  <xsl:include href="layout-utils.xsl" />

  <xsl:param name="MIR.OAS" select="'hide'" />

  <xsl:template match="/site">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <head>
        <xsl:apply-templates select="citation_meta" mode="copyContent" />
        <link href="{$WebApplicationBaseURL}assets/jquery/plugins/shariff/shariff.min.css" rel="stylesheet" />
        <script type="text/javascript" src="{$WebApplicationBaseURL}assets/jquery/plugins/dotdotdot/jquery.dotdotdot.min.js" />
      </head>

      <xsl:if test="div[@id='mir-breadcrumb']">
        <breadcrumb>
          <xsl:copy-of select="div[@id='mir-breadcrumb']/*" />
        </breadcrumb>
      </xsl:if>

      <xsl:if test="div[@id='search_browsing']">
        <div class="row detail_row" id="mir-search_browsing">
          <div class="col-md-8">
            <div class="detail_block text-center">
              <!-- span id="pagination_label">gefundende Dokumente</span -->
              <br />
              <!-- Start: PAGINATION -->
              <xsl:apply-templates select="div[@id='search_browsing']" mode="copyContent" />
              <!-- End: PAGINATION -->
            </div>
          </div>
        </div>
      </xsl:if>

      <!-- Start: MESSAGE -->
      <xsl:if test="div[@id='mir-message']">
        <div class="row detail_row">
          <div class="col-md-12">
            <xsl:copy-of select="div[@id='mir-message']/*" />
          </div>
        </div>
      </xsl:if>
      <!-- End: MESSAGE -->

      <div class="row detail_row" itemscope="itemscope" itemtype="http://schema.org/ScholarlyArticle">

        <div id="head_col" class="col-xs-12">
          <div class="row">
            <div id="aux_col_actions" class="col-xs-12 col-sm-4 col-sm-push-8 col-md-4 col-md-push-8">
              <div class="pull-right">
                <!-- Start: EDIT -->
                <xsl:apply-templates select="div[@id='mir-edit']" mode="copyContent" />
                <!-- End: EDIT -->
              </div>
            </div>
            <div class="col-xs-12 col-sm-8 col-sm-pull-4 col-md-8 col-md-pull-4">
              <xsl:apply-templates select="div[@id='mir-abstract-badges']" mode="copyContent" />
            </div>
          </div>
        </div>

        <div id="main_col" class="col-xs-12 col-sm-8">

          <div id="headline">
            <xsl:apply-templates select="div[@id='ggrass-title']" mode="copyContent" />
          </div>

  <!-- Nav tabs -->
  <ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active"><a href="#ggrass_content" aria-controls="ggrass_content" role="tab" data-toggle="tab">Inhaltliche Daten</a></li>
    <li role="presentation"><a href="#ggrass_technics" aria-controls="ggrass_technics" role="tab" data-toggle="tab">Technische Daten</a></li>
    <li role="presentation"><a href="#ggrass_persons" aria-controls="ggrass_persons" role="tab" data-toggle="tab">Personen und Verweise</a></li>
    <li role="presentation"><a href="#ggrass_notes" aria-controls="ggrass_notes" role="tab" data-toggle="tab">Anmerkungen</a></li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content">
    <div role="tabpanel" class="tab-pane active" id="ggrass_content">
      <div class="row">
        <div class="col-md-9 col-md-offset-3">

          <!-- Start: ABSTRACT -->
          <xsl:if test="div[@id = 'mir-abstract-plus']">
            <div class="detail_block">
              <xsl:apply-templates select="div[@id='mir-abstract-plus']" mode="copyContent" />
            </div>
            <hr class="ggrass_hr" />
          </xsl:if>
          <!-- End: ABSTRACT -->

          <!-- viewer -->
          <!-- xsl:if test="div[@id = 'mir-viewer']">
            <div class="detail_block" id="mir-viewer">
              <xsl:apply-templates select="div[@id='mir-viewer']" mode="copyContent" />
            </div>
          </xsl:if -->
          <!-- player -->
          <xsl:if test="div[@id = 'mir-player']">
            <div class="detail_block" id="mir-player">
              <xsl:apply-templates select="div[@id='mir-player']" mode="copyContent" />
            </div>
          </xsl:if>
          <!-- files -->
          <xsl:if test="div[contains(@id,'mir-collapse-')] and not(mcrxsl:isCurrentUserGuestUser())">
            <div class="detail_block" id="mir-collapse-files">
              <div class="" id="record_detail">
                <xsl:apply-templates select="div[@id='mir-collapse-files']" mode="copyContent" />
              </div>
            </div>
          </xsl:if>
          <xsl:if test="div[@id = 'mir-viewer'] or div[contains(@id,'mir-collapse-')]">
            <hr class="ggrass_hr" />
          </xsl:if>
        </div>
      </div>

      <div id="ggrass-title-metadata">
        <xsl:apply-templates select="div[@id='ggrass-title-metadata']" mode="copyContent" />
      </div>

    </div>

    <div role="tabpanel" class="tab-pane" id="ggrass_technics">
      <div id="ggrass-technical-metadata">
        <xsl:apply-templates select="div[@id='ggrass-technical-metadata']" mode="copyContent" />
      </div>
    </div>


    <div role="tabpanel" class="tab-pane" id="ggrass_persons">
      <div id="ggrass-persons-metadata">
        <xsl:apply-templates select="div[@id='ggrass-persons-metadata']" mode="copyContent" />
      </div>
    </div>

    <div role="tabpanel" class="tab-pane" id="ggrass_notes">
      <div id="ggrass-notes-metadata">
        <xsl:apply-templates select="div[@id='ggrass-notes-metadata']" mode="copyContent" />
      </div>
    </div>
  </div>




<!-- end: left column -->
        </div>

<!-- right column -->
        <div id="aux_col" class="col-xs-12 col-sm-4">

<!-- cites -->
          <xsl:if test="div[@id='mir-citation']">
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Zitieren</h3>
              </div>
              <div class="panel-body">
                <!-- Start: CITATION -->
                <xsl:apply-templates select="div[@id='mir-citation']" mode="copyContent" />
                <!-- End: CITATION -->
              </div>
            </div>
          </xsl:if>
<!-- OAS statistics -->
          <xsl:if test="$MIR.OAS = 'show' and div[@id='mir-oastatistics']">
            <div class="panel panel-default">
              <div class="panel-heading">
                <div class="row"> 
                  <h3 class="panel-title col-md-9" style="margin-top:10px">
                  <xsl:value-of select="i18n:translate('mir.oas.panelheading')" />
                </h3>
                  <div class="col-md-3 text-right"><img src="{$WebApplicationBaseURL}images/epusta/epustalogo_small.png" style="height: 40px;"/></div>
                </div>
              </div>
              <div class="panel-body">
                <xsl:apply-templates select="div[@id='mir-oastatistics']" mode="copyContent" />
              </div>
            </div>
          </xsl:if>
<!-- rights -->
          <xsl:if test="div[@id='mir-access-rights']">
            <div id="mir_access_rights_panel" class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Rechte</h3>
              </div>
              <div class="panel-body">
                <!-- Start: CITATION -->
                <xsl:apply-templates select="div[@id='mir-access-rights']" mode="copyContent" />
                <!-- End: CITATION -->
              </div>
            </div>
          </xsl:if>
<!-- export -->
          <xsl:if test="div[@id='mir-export']">
            <div id="mir_export_panel" class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Export</h3>
              </div>
              <div class="panel-body">
                  <!-- Start: EXPORT -->
                <xsl:apply-templates select="div[@id='mir-export']" mode="copyContent" />
                  <!-- End: EXPORT -->
              </div>
            </div>
          </xsl:if>
<!-- system -->
          <xsl:if test="not(mcrxsl:isCurrentUserGuestUser()) and @read">
            <div id="mir_admindata_panel" class="panel panel-default system">
              <div class="panel-heading">
                <h3 class="panel-title">
                  <xsl:value-of select="i18n:translate('component.mods.metaData.dictionary.systembox')" />
                </h3>
              </div>
              <div class="panel-body">
                <!-- Start: ADMINMETADATA -->
                <xsl:apply-templates select="div[@id='mir-admindata']" mode="newMetadata" />
                <!-- End: ADMINMETADATA -->
              </div>
              <div class="modal fade" id="historyModal" tabindex="-1" role="dialog" aria-labelledby="modal frame" aria-hidden="true">
                <div class="modal-dialog" style="width: 930px">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close modalFrame-cancel" data-dismiss="modal" aria-label="Close">
                        <i class="fa fa-times" aria-hidden="true"></i>
                      </button>
                      <h4 class="modal-title" id="modalFrame-title">
                        <xsl:value-of select="i18n:translate('metadata.versionInfo.label')" />
                      </h4>
                    </div>
                    <div id="modalFrame-body" class="modal-body" style="max-height: 560px; overflow: auto">
                      <xsl:apply-templates select="div[@id='mir-historydata']" mode="copyContent" />
                    </div>
                    <div class="modal-footer" style="clear: both">
                      <button id="modalFrame-cancel" type="button" class="btn btn-danger" data-dismiss="modal">
                        <xsl:value-of select="i18n:translate('button.cancel')" />
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </xsl:if>

<!-- end: right column -->
        </div>

<!--  end: detail row -->
      </div>
      <script src="{$WebApplicationBaseURL}assets/jquery/plugins/shariff/shariff.min.js"></script>
      <script src="{$WebApplicationBaseURL}assets/moment/moment.js"></script>
      <script src="{$WebApplicationBaseURL}assets/handlebars/handlebars.min.js"></script>
      <script src="{$WebApplicationBaseURL}js/mir/derivate-fileList.js"></script>
      <link rel="stylesheet" href="{$WebApplicationBaseURL}rsc/stat/{@ID}.css"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="citation_meta" mode="copyContent">
    <xsl:message>
      <xsl:value-of select="'Handling citation meta tags'" />
    </xsl:message>
    <xsl:copy-of select="./*" />
  </xsl:template>

  <xsl:template match="div" mode="copyContent">
    <xsl:message>
      <xsl:value-of select="concat('Handling div: ',@id)" />
    </xsl:message>
    <xsl:copy-of select="./*" />
  </xsl:template>

  <xsl:template match="div[@id='mir-metadata']" mode="newMetadata">
    <dl>
      <xsl:apply-templates select="table[@class='mir-metadata']/tr" mode="newMetadata" />
    </dl>
  </xsl:template>
  <xsl:template match="div[@id='mir-admindata']" mode="newMetadata">
    <dl>
      <xsl:apply-templates select=".//div[@id='system_box']/div[@id='system_content']/table/tr" mode="newMetadata" />
    </dl>
  </xsl:template>
  <xsl:template match="td[@class='metaname']" mode="newMetadata" priority="2">
    <dt>
      <xsl:copy-of select="node()|*" />
    </dt>
  </xsl:template>
  <xsl:template match="td[@class='metavalue']" mode="newMetadata" priority="2">
    <dd>
      <xsl:copy-of select="node()|*" />
    </dd>
  </xsl:template>

</xsl:stylesheet>