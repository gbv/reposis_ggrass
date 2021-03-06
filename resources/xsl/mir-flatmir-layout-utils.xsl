<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:mcrver="xalan://org.mycore.common.MCRCoreVersion"
    xmlns:calendar="xalan://java.util.GregorianCalendar"
    exclude-result-prefixes="mcrver calendar">

  <xsl:import href="resource:xsl/layout/mir-common-layout.xsl" />
  <xsl:param name="piwikID" select="'0'" />

  <xsl:template name="mir.navigation">

    <div id="header_box" class="clearfix container">

      <!-- logo -->
      <div id="project_logo_box">
        <a title="zur Homepage der Günter Grass Stiftung Bremen - Medienarchiv" href="http://www.grass-medienarchiv.de">
          <img alt="Logo der Günter Grass Stiftung Bremen" src="{$WebApplicationBaseURL}images/logos/ggrass_logo.png" />
        </a>
      </div>

      <!-- options -->
      <div id="options_nav_box" class="mir-prop-nav">
        <div class="searchfield_box">
          <form action="{$WebApplicationBaseURL}servlets/solr/find?q={0}" class="navbar-form navbar-left pull-right" role="search">
            <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i></button>
            <div class="form-group">
              <input name="q" placeholder="Schnellsuche" class="form-control search-query" id="searchInput" type="text" />
            </div>
          </form>
        </div>
        <nav>
          <ul class="nav navbar-nav pull-right">
            <xsl:call-template name="mir.loginMenu" />
          </ul>
        </nav>
      </div>

      <!-- name -->
      <div id="project_name_box">
        <h1><a href="{$WebApplicationBaseURL}">Webdatenbank</a></h1>
        <h2>Medienarchiv</h2>
      </div>

      <!-- cite -->
      <div id="header_cite_box">
        <div class="cite">
          „Gestern wird sein, was morgen gewesen ist.
          Unsere Geschichten von heute müssen sich
          nicht jetzt zugetragen haben.“
        </div>
        <div class="source">
          Günter Grass, Das Treffen in Telgte (1979)
        </div>
      </div>

    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="navbar navbar-default mir-main-nav">
      <div class="container">

        <div class="navbar-header">
          <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".mir-main-nav-entries">
            <span class="sr-only"> Toggle navigation </span>
            <span class="icon-bar">
            </span>
            <span class="icon-bar">
            </span>
            <span class="icon-bar">
            </span>
          </button>
        </div>

        <nav class="collapse navbar-collapse mir-main-nav-entries">
          <ul class="nav navbar-nav pull-left">
            <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='search']" />
            <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='browse']" />
            <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='register']/*" />
            <!--  xsl:apply-templates select="$loaded_navigation_xml/menu[@id='publish']" / -->
            <xsl:call-template name="mir.basketMenu" />
          </ul>
        </nav>

      </div><!-- /container -->
    </div>
  </xsl:template>

  <xsl:template name="mir.jumbotwo">
    <!-- do nothing special -->
  </xsl:template>

  <xsl:template name="mir.footer">
    <div class="container">
      <div class="row">
        <div class="col-md-4">
          <xsl:variable name="tmp" select="calendar:new()"/>
          <p>
            <xsl:text>© </xsl:text>
            <xsl:value-of select="calendar:get($tmp, 1)"/>
            <xsl:text> Günter Grass Stiftung Bremen - Medienarchiv</xsl:text>
          </p>
        </div>
        <div class="col-md-8">
          <ul class="internal_links nav navbar-nav">
            <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='below']/*" />
          </ul>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="mir.powered_by">
    <xsl:variable name="mcr_version" select="concat('MyCoRe ',mcrver:getCompleteVersion())" />
    <div class="container">
      <div class="row">
        <div class="col-md-6">
          <div id="powered_by">
            <a href="http://www.mycore.de">
              <img src="{$WebApplicationBaseURL}mir-layout/images/mycore_logo_small_invert.png" title="{$mcr_version}" alt="powered by MyCoRe" />
            </a>
          </div>
        </div>
        <div class="col-md-6">
          <div id="sponsored_by">
            <a href="http://www.dfg.de">
              <img src="{$WebApplicationBaseURL}images/logos/dfg_logo_gbv.svg" title="Die Entwicklung der Datenbank ist ein Kooperationsprojekt mit der VZG und wurde von der DFG gefördert. " alt="sponsored by DFG, hostet by VZG" />
            </a>
          </div>
        </div>
      </div>
    </div>
    <script type="text/javascript" src="{$WebApplicationBaseURL}js/jquery.cookiebar.js"></script>
    <!-- Piwik -->
    <xsl:if test="$piwikID &gt; 0">
      <script type="text/javascript">
            var _paq = _paq || [];
            _paq.push(['setDoNotTrack', true]);
            _paq.push(['trackPageView']);
            _paq.push(['enableLinkTracking']);
            (function() {
              var u="https://piwik.gbv.de/";
              var objectID = '<xsl:value-of select="//site/@ID" />';
              if(objectID != "") {
                _paq.push(["setCustomVariable",1, "object", objectID, "page"]);
              }
              _paq.push(['setTrackerUrl', u+'piwik.php']);
              _paq.push(['setSiteId', '<xsl:value-of select="$piwikID" />']);
              _paq.push(['setDownloadExtensions', '7z|aac|arc|arj|asf|asx|avi|bin|bz|bz2|csv|deb|dmg|doc|exe|flv|gif|gz|gzip|hqx|jar|jpg|jpeg|js|mp2|mp3|mp4|mpg|mpeg|mov|movie|msi|msp|odb|odf|odg|odp|ods|odt|ogg|ogv|pdf|phps|png|ppt|qt|qtm|ra|ram|rar|rpm|sea|sit|tar|tbz|tbz2|tgz|torrent|txt|wav|wma|wmv|wpd|z|zip']);
              var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
              g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'piwik.js'; s.parentNode.insertBefore(g,s);
            })();
      </script>
      <noscript><p><img src="https://piwik.gbv.de/piwik.php?idsite={$piwikID}" style="border:0;" alt="" /></p></noscript>
    </xsl:if>
    <!-- End Piwik Code -->
  </xsl:template>

</xsl:stylesheet>