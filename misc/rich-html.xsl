<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE stylesheet [
<!ENTITY nbsp "&#160;"> <!-- NON-BREAKING SPACE -->
<!ENTITY acute "&#x00B4;">		<!-- ACUTE ACCENT -->
<!ENTITY slongdes "&#xF127;"> <!-- LATIN SMALL LETTER LONG S DESCENDING -->
<!ENTITY combacute "&#x0301;">      <!-- COMBINING ACUTE ACCENT -->
<!ENTITY csup "&#x0368;">       <!-- COMBINING LATIN SMALL LETTER C -->
<!ENTITY ydotacute "&#xE784;">      <!-- LATIN SMALL LETTER Y WITH DOT ABOVE AND ACUTE -->
<!ENTITY bidotscomposit "&#xF1F2;">		<!-- TWO DOTS OVER COMMA POSITURA -->
<!ENTITY punctelev "&#xF161;">		<!-- PUNCTUS ELEVATUS -->
<!ENTITY punctvers "&#xF1EA;">		<!-- PUNCTUS VERSUS -->
<!ENTITY punctelevdiag "&#xF1F0;">		<!-- PUNCTUS ELEVATUS DIAGONAL STROKE -->
<!ENTITY THORNbarslash "&#xE337;">		<!-- LATIN CAPITAL LETTER THORN WITH DIAGONAL STROKE -->
<!ENTITY thornbarslash "&#xF149;">		<!-- LATIN SMALL LETTER THORN WITH DIAGONAL STROKE -->
<!ENTITY ilong "&#xF220;">		<!-- LATIN SMALL LETTER LONG I -->
<!ENTITY orrotlig "&#xE8DE;">		<!-- LATIN SMALL LIGATURE OR ROTUNDA-->
<!ENTITY rrot "&#xA75B;">		<!-- LATIN SMALL LETTER R ROTUNDA -->
<!ENTITY ET "&#x2E52;">		<!-- LATIN ABBREVIATION SIGN CAPITAL ET -->
<!ENTITY et "&#x204A;">		<!-- TIRONIAN SIGN ET -->
<!ENTITY colmidcomposit "&#xF1E5;">		<!-- COLON WITH MIDDLE COMMA POSITURA -->
<!ENTITY ogon "&#x02DB;">		<!-- OGONEK -->
<!ENTITY ndot "&#x1E45;">		<!-- LATIN SMALL LETTER N WITH DOT ABOVE -->
<!ENTITY rdot "&#x1E59;">		<!-- LATIN SMALL LETTER R WITH DOT ABOVE -->
<!ENTITY tridotsupw "&#x2E2B;">		<!-- ONE DOT OVER TWO DOTS PUNCTUATION -->
]>
<!-- Stylesheet written by Paul Langeslag 2024 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
	xmlns:functx="http://www.functx.com" 
    exclude-result-prefixes="#all"
    version="2.0">

<xsl:import href="https://raw.githubusercontent.com/transpect/xslt-util/master/functx/xsl/functx.xsl"/><!-- as xsltfunctions.com has gone missing -->
    <xsl:output method="html" omit-xml-declaration="yes" />
    <xsl:strip-space elements="tei:choice tei:w"/>
    
<xsl:param name="proofing"/>

     <xsl:template match="/">
	  <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;&#xa;</xsl:text>
	  <html>
   		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    		<title>
  	 			<xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
    		</title>
			<xsl:if test="$proofing = 'true'">
				<link rel ="stylesheet" href="style.css" type="text/css"/>
			</xsl:if>
   		</head>
			<body>
        <xsl:for-each select="tei:TEI">
            <xsl:apply-templates select="tei:text"/>
        </xsl:for-each>
			</body>
	  	</html>
    </xsl:template>
    
    <xsl:template match="tei:text">
        <main class="tei-text">
            <xsl:apply-templates/>
        </main>
    </xsl:template>

   
    <xsl:template match="tei:w">
        <span class="tei-w">
			<xsl:if test="@part">
	            <xsl:attribute name="data-tei-part">
    	            <xsl:value-of select="@part"/>
        	    </xsl:attribute>
			</xsl:if>
			<xsl:if test="@xml:id">
	            <xsl:attribute name="data-tei-xml-id">
    	            <xsl:value-of select="@xml:id"/>
        	    </xsl:attribute>
			</xsl:if>
			<xsl:if test="@notation">
	            <xsl:attribute name="data-tei-notation">
    	            <xsl:value-of select="@notation"/>
        	    </xsl:attribute>
			</xsl:if>
			<xsl:if test="contains(@xml:id, 'trans')">
	            <xsl:attribute name="data-echoe-trans-pos">
    	            <xsl:value-of select="@ana"/>
        	    </xsl:attribute>
			</xsl:if>
            <xsl:choose>
				<xsl:when test="@xml:lang = 'la|hbo|grc' or ancestor::*[@xml:lang] = 'la|hbo|grc'">
					<span class="data-xml-lang">
                    	<xsl:apply-templates/>
					</span>
				</xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>

    <xsl:template match="tei:head">
        <div class="tei-head"><xsl:apply-templates/></div>
    </xsl:template>
    
    <xsl:template match="tei:choice">
        <span class="tei-choice">
			<xsl:if test="contains(@xml:id, 'trans')">
	            <xsl:attribute name="data-echoe-trans-pos">
    	            <xsl:value-of select="@ana"/>
        	    </xsl:attribute>
			</xsl:if>
		<xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="tei:trailer">
        <div class="tei-trailer"><xsl:apply-templates/></div>
    </xsl:template>
    
    <xsl:template match="tei:sic">
        <span class="tei-sic"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="tei:corr">
        <span class="tei-corr"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="tei:abbr">
        <span class="tei-abbr">
            <xsl:choose>
                <xsl:when test="ancestor::tei:w and count(child::tei:am) > 0">
                    <span class="echoe-word-abbreviated">
                        <xsl:value-of select="descendant-or-self::text()"/>
                    </span>
                </xsl:when>
                <xsl:otherwise>
                    <span class="tei-choice"><xsl:apply-templates/></span>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:am">
        <span class="tei-am">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
   <xsl:template match="tei:expan">
        <span class="tei-expan"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="tei:ex">
        <span class="tei-ex"><xsl:apply-templates/></span>
    </xsl:template>
     
    <xsl:template match="tei:pc">
        <span class="tei-pc"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="tei:subst">
        <span class="tei-subst">
			<xsl:if test="contains(@xml:id, 'trans')">
	            <xsl:attribute name="data-echoe-trans-pos">
    	            <xsl:value-of select="@ana"/>
        	    </xsl:attribute>
			</xsl:if>
			<xsl:if test="contains(@xml:id, 'undo')">
	            <xsl:attribute name="data-echoe-revision">
    	            <xsl:text>undo</xsl:text>
        	    </xsl:attribute>
			</xsl:if>
			<xsl:if test="contains(@xml:id, 'redo')">
	            <xsl:attribute name="data-echoe-revision">
    	            <xsl:text>redo</xsl:text>
        	    </xsl:attribute>
			</xsl:if>
		<xsl:apply-templates/></span>
    </xsl:template>

     <xsl:template match="tei:orig">
        <span class="tei-orig"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="tei:reg">
        <span class="tei-reg">
			<xsl:attribute name="title">
				<xsl:value-of select="preceding-sibling::tei:orig"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</span>
    </xsl:template>

    <xsl:template match="tei:lb">
		<xsl:if test="not(ancestor::tei:w)">
		 <xsl:text> </xsl:text>
		</xsl:if>
        <span class="tei-lb">
            <xsl:attribute name="data-tei-n">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:pb">
        <span class="tei-pb">
            <xsl:attribute name="data-tei-n">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:gap">
        <span class="tei-gap">
            <xsl:attribute name="data-tei-reason">
                <xsl:value-of select="@reason"/>
            </xsl:attribute>
            <xsl:attribute name="data-tei-quantity">
                <xsl:value-of select="@quantity"/>
            </xsl:attribute>
            <xsl:attribute name="data-tei-unit">
                <xsl:value-of select="@unit"/>
            </xsl:attribute>
        </span>
    </xsl:template>

	<xsl:template match="tei:g">
		<span class="tei-g">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
    
    <xsl:template match="tei:num">
        <span class="tei-num">
            <xsl:attribute name="data-tei-n">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:foreign">
        <span class="tei-foreign">
            <xsl:attribute name="data-xml-lang">
                <xsl:value-of select="@xml:lang"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:quote">
        <span class="tei-quote">
            <xsl:attribute name="data-source">
                <xsl:value-of select="functx:replace-multi(replace(lower-case(@source), ' ', ', '),$abbreviations,$expansions)"/>
            </xsl:attribute>
			<xsl:if test="@xml:lang">
            	<xsl:attribute name="xml-lang">
                	<xsl:value-of select="@xml:lang"/>
				</xsl:attribute>
			</xsl:if>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:persName">
        <span class="tei-persName">
			<xsl:if test="@xml:id">
             	<xsl:attribute name="data-tei-xml-id">
                 	<xsl:value-of select="@xml:id"/>
             	</xsl:attribute>
			</xsl:if>
            <xsl:attribute name="data-tei-key">
                <xsl:value-of select="@key"/>
            </xsl:attribute>
			<!-- Prosopographical data if available: -->
			<xsl:if test="@ref">
             	<xsl:attribute name="data-tei-ref">
                 	<xsl:value-of select="@ref"/>
             	</xsl:attribute>
			</xsl:if>
        </span>
    </xsl:template>

    <xsl:template match="tei:placeName">
        <span class="tei-placeName">
			<xsl:if test="@xml:id">
             	<xsl:attribute name="data-tei-xml-id">
                 	<xsl:value-of select="@xml:id"/>
             	</xsl:attribute>
			</xsl:if>
            <xsl:attribute name="data-tei-key">
                <xsl:value-of select="@key"/>
            </xsl:attribute>
			<!-- Geolocation if available: -->
			<xsl:if test="@ref">
            <xsl:attribute name="data-tei-ref">
                <xsl:value-of select="@ref"/>
            </xsl:attribute>
			</xsl:if>
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:name">
        <span class="tei-name">
			<xsl:if test="@xml:id">
             	<xsl:attribute name="data-tei-xml-id">
                 	<xsl:value-of select="@xml:id"/>
             	</xsl:attribute>
			</xsl:if>
			<xsl:if test="contains(@xml:id, 'trans')">
	            <xsl:attribute name="data-echoe-trans-pos">
    	            <xsl:value-of select="@ana"/>
        	    </xsl:attribute>
			</xsl:if>
            <xsl:attribute name="data-tei-type">
                <xsl:value-of select="@type"/>
            </xsl:attribute>
            <xsl:attribute name="data-tei-key">
                <xsl:value-of select="@key"/>
            </xsl:attribute>
			<!-- Geolocation if available: -->
			<xsl:if test="@ref">
            <xsl:attribute name="data-tei-ref">
                <xsl:value-of select="@ref"/>
            </xsl:attribute>
			</xsl:if>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:unclear">
        <span class="tei-unclear">
            <xsl:attribute name="data-tei-reason">
                <xsl:value-of select="@reason"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:handShift">
        <span class="tei-handShift">
            <xsl:attribute name="data-tei-script">
                <xsl:value-of select="@script"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:hi">
        <span class="tei-hi">
            <xsl:attribute name="data-tei-rend">
                <xsl:value-of select="@rend"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:add">
        <span class="tei-add">
            <xsl:attribute name="data-tei-type">
                <xsl:value-of select="@type"/>
            </xsl:attribute>
            <xsl:attribute name="data-tei-place">
                <xsl:value-of select="@place"/>
            </xsl:attribute>
            <xsl:attribute name="data-tei-hand">
                <xsl:value-of select="@hand"/>
            </xsl:attribute>
			<xsl:if test="contains(@xml:id, 'undo')">
	            <xsl:attribute name="data-echoe-revision">
    	            <xsl:text>undo</xsl:text>
        	    </xsl:attribute>
			</xsl:if>
			<xsl:if test="contains(@xml:id, 'redo')">
	            <xsl:attribute name="data-echoe-revision">
    	            <xsl:text>redo</xsl:text>
        	    </xsl:attribute>
			</xsl:if>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:del">
        <span class="tei-del">
            <xsl:attribute name="data-tei-rend">
                <xsl:value-of select="@rend"/>
            </xsl:attribute>
            <xsl:attribute name="data-tei-hand">
                <xsl:value-of select="@hand"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:s">
        <span class="tei-s">
            <xsl:attribute name="data-xml-id">
                <xsl:value-of select="substring(@xml:id, 2)"/>
            </xsl:attribute>
			<xsl:choose>
				<xsl:when test="@n">
	            	<xsl:attribute name="data-tei-n">
    	            	<xsl:value-of select="translate(@n, ' x', ',')"/>
        	    	</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
	            	<xsl:attribute name="data-tei-n">
                		<xsl:value-of select="substring(@xml:id, 2)"/>
        	    	</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<a>
				<xsl:attribute name="id">
					<xsl:value-of select="@xml:id"/>
				</xsl:attribute>
				<xsl:attribute name="href">
					<xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/>
				</xsl:attribute>
				<span class="echoe-sentence-number">
               		<xsl:value-of select="substring(@xml:id, 2)"/>
            	</span>
			</a>
            <span class="echoe-sentence-content">
                <xsl:apply-templates/>
            </span>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:supplied">
         <span class="tei-supplied">
             <xsl:attribute name="data-tei-reason">
                 <xsl:value-of select="@reason"/>
             </xsl:attribute>
             <xsl:attribute name="data-tei-evidence">
                 <xsl:value-of select="@evidence"/>
             </xsl:attribute>
             <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:fw">
		<span class="tei-fw">
             <xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="tei:seg">
		<xsl:choose>
			<xsl:when test="@type = 'transpose'">
				<span class="pretransposition">
					<xsl:apply-templates/>
				</span>
				<span class="posttransposition">
					<xsl:apply-templates>
						<xsl:sort select="@ana"/>
					</xsl:apply-templates>
				</span>
			</xsl:when>
			<xsl:when test="@ana = 'binomial'">
				<span class="echoe-binomial"><xsl:apply-templates/></span>
			</xsl:when>
			<xsl:when test="@ana = 'enumeration'">
			<span class="echoe-enum"><xsl:apply-templates/></span>
			</xsl:when>
			<xsl:when test="@ana = 'verseLike'">
			<span class="echoe-verselike"><xsl:apply-templates/></span>
			</xsl:when>
			<xsl:otherwise>
				<span class="tei-seg">
					<xsl:if test="@xml:id">
            				 	<xsl:attribute name="data-tei-xml-id">
        				         	<xsl:value-of select="@xml:id"/>
     				        	</xsl:attribute>
							</xsl:if>
							<xsl:if test="contains(@xml:id, 'trans')">
	          				  <xsl:attribute name="data-echoe-trans-pos">
    	 				           <xsl:value-of select="@ana"/>
   				     	    </xsl:attribute>
							</xsl:if>
							<xsl:if test="contains(@xml:id, 'undo')">
	        				    <xsl:attribute name="data-echoe-revision">
    					            <xsl:text>undo</xsl:text>
    				    	    </xsl:attribute>
							</xsl:if>
							<xsl:if test="contains(@xml:id, 'redo')">
	          				  <xsl:attribute name="data-echoe-revision">
    	           				 <xsl:text>redo</xsl:text>
        	  				  </xsl:attribute>
							</xsl:if>
 				            <xsl:attribute name="data-tei-type">
               				  <xsl:value-of select="@type"/>
           				  </xsl:attribute>
         				    <xsl:apply-templates/>
						</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

    <xsl:template match="tei:note">
		<span class="tei-note">
             <xsl:attribute name="data-tei-type">
                 <xsl:value-of select="@type"/>
             </xsl:attribute>
             <xsl:apply-templates/>
		</span>
	</xsl:template>

    <xsl:template match="tei:surplus">
		<span class="tei-surplus">
             <xsl:apply-templates/>
		</span>
	</xsl:template>

    <xsl:template match="tei:restore">
		<span class="tei-restore">
             <xsl:apply-templates/>
		</span>
	</xsl:template>

    <xsl:template match="tei:ab">
		<span class="tei-ab">
             <xsl:apply-templates/>
		</span>
	</xsl:template>

<!--The following template uses a custom recursive implementation of the XSLT 2.0 function `replace` to normalize features. It requires for the functx namespace to be loaded and library to be imported. In its present form a stock replace() would actually do, but I'm keeping this in case we end up filtering more out. -->
 <xsl:variable name="before" select="('\n\s*')"/>
 <xsl:variable name="after" select="('')"/>
 <xsl:template match="text()">
     <xsl:value-of select="functx:replace-multi(.,$before,$after)"/>
 </xsl:template>
 <!-- The following variables serve the expansion of @source abbreviations. Since the method of replacement is recursive and nonrobust in the absence of regex, values have been reordered to avoid chain replacements, while The Song of Solomon ("Ct"), Amos ("Am"), Micah ("Mi"), and Zephaniah ("So"), hitherto absent from corpus source references, have been left out for the same reason. -->
 <xsl:variable name="abbreviations" select="('os', 'na', 'ex', 'lv', 'nm', 'idt', 'dt', 'ios', 'idc', 'rt', 'iism', 'ism', 'is', 'iiirg', 'ivrg', 'iipar', 'ipar', 'iiesr', 'iesr', 'tb', 'est', 'iob', 'ps', 'prv', 'ecl', 'sap', 'sir', 'gn', 'ier', 'lam', 'bar', 'ez', 'dn', 'ioel', 'abd', 'ion', 'hab', 'agg', 'za', 'mal', 'iimcc', 'imcc', 'mt', 'mc', 'lc', 'iiiio', 'iiio', 'iio', 'io', 'act', 'orman', 'rm', 'iicor', 'icor', 'gal', 'eph', 'phlm', 'phil', 'col', 'iith', 'ith', 'iitim', 'itim', 'tit', 'hbr', 'iac', 'iipt', 'ipt', 'iud', 'apc', 'iiiesr', 'ivesr', '\.')"/>
 <xsl:variable name="expansions" select="('Hosea ', 'Nahum ', 'Exodus ', 'Leviticus ', 'Numeri ', 'Judith ', 'Deuteronomy ', 'Joshua ', 'Judges ', 'Ruth ', '2 Samuel/II Regum ', '1 Samuel/I Regum ', 'Isaiah ', '1 Kings/III Regum ', '2 Kings/IV Regum ', '2 Chronicles ', '1 Chronicles ', '2 Esdras ', '1 Esdras ', 'Tobias ', 'Esther ', 'Job ', 'Psalms ', 'Proverbs ', 'Ecclesiastes ', 'Wisdom ', 'Ecclesiasticus ', 'Genesis ', 'Jeremiah ', 'Lamentations ', 'Baruch ', 'Ezekiel ', 'Daniel ', 'Joel ', 'Obadiah ', 'Jonah ', 'Habakkuk ', 'Haggai ', 'Zechariah ', 'Malachi ', '2 Maccabees ', '1 Maccabees ', 'Matthew ', 'Mark ', 'Luke ', '3 John ', '2 John ', '1 John ', 'John ', 'Acts ', 'Prayer of Manasses ', 'Romans ', '2 Corinthians ', '1 Corinthians ', 'Galatians ', 'Ephesians ', 'Philemon ', 'Philippians ', 'Colossians ', '2 Thessalonians ', '1 Thessalonians ', '2 Timothy ', '1 Timothy ', 'Titus ', 'Hebrews ', 'James ', '2 Peter ', '1 Peter ', 'Jude ', 'Apocalypse ', '3 Esdras ', '4 Esdras ', ':')"/>
   
</xsl:stylesheet>
