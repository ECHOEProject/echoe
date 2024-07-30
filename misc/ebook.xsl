<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY gt "&#x003E;">		<!-- GREATER-THAN SIGN -->
<!ENTITY tld "&#x007E;">		<!-- TILDE -->
<!ENTITY nbsp "&#160;"> <!-- NON-BREAKING SPACE -->
<!ENTITY dblldr "&#x2025;">		<!-- TWO DOT LEADER -->
<!ENTITY est "&#x223B;">		<!-- HOMOTHETIC -->
<!ENTITY slongdes "&#xF127;"> <!-- LATIN SMALL LETTER LONG S DESCENDING -->
<!ENTITY combacute "&#x0301;">      <!-- COMBINING ACUTE ACCENT -->
<!ENTITY csup "&#x0368;">       <!-- COMBINING LATIN SMALL LETTER C -->
<!ENTITY ydotacute "&#xE784;">      <!-- LATIN SMALL LETTER Y WITH DOT ABOVE AND ACUTE -->
<!ENTITY bidotscomposit "&#xF1F2;">		<!-- TWO DOTS OVER COMMA POSITURA -->
<!ENTITY tridotscomposit "&#xF1E6;">		<!-- THREE DOTS WITH COMMA POSITURA -->
<!ENTITY punctelev "&#xF161;">		<!-- PUNCTUS ELEVATUS -->
<!ENTITY punctelevdiag "&#xF1F0;">		<!-- PUNCTUS ELEVATUS DIAGONAL STROKE -->
<!ENTITY punctvers "&#xF1EA;">		<!-- PUNCTUS VERSUS -->
<!ENTITY lozengedot "&#x2058;">		<!-- FOUR DOT PUNCTUATION -->
<!ENTITY THORNbarslash "&#xE337;">		<!-- LATIN CAPITAL LETTER THORN WITH DIAGONAL STROKE -->
<!ENTITY thornbarslash "&#xF149;">		<!-- LATIN SMALL LETTER THORN WITH DIAGONAL STROKE -->
<!ENTITY ilong "&#xF220;">		<!-- LATIN SMALL LETTER LONG I -->
<!ENTITY middot "&#x00B7;">		<!-- MIDDLE DOT -->
<!ENTITY punctflex "&#xF1F5;">		<!-- PUNCTUS FLEXUS -->
<!ENTITY posit "&#xF1E2;">		<!-- COMMA POSITURA -->
<!ENTITY punctposit "&#xF1E4;"> <!-- PUNCTUS WITH COMMA POSITURA -->
<!ENTITY colmidcomposit "&#xF1E5;">		<!-- COLON WITH MIDDLE COMMA POSITURA -->
<!ENTITY renvoi "&#xF1EC;">		<!-- SIGNE DE RENVOI -->
<!ENTITY tridotright "&#x10FB;">		<!-- PUNCTUATION MARK RIGHT-POINTING TRIANGULAR DOTS -->
<!ENTITY tridotsupw "&#x2E2B;">		<!-- ONE DOT OVER TWO DOTS PUNCTUATION -->
<!ENTITY tridotdw "&#x2235;">		<!-- BECAUSE -->
<!ENTITY orrotlig "&#xE8DE;">		<!-- LATIN SMALL LIGATURE OR ROTUNDA-->
<!ENTITY rrot "&#xA75B;">		<!-- LATIN SMALL LETTER R ROTUNDA -->
<!ENTITY ogon "&#x02DB;">		<!-- OGONEK -->
<!ENTITY Eogon "&#x0118;">		<!-- LATIN CAPITAL LETTER E WITH OGONEK -->
<!ENTITY eogon "&#x0119;">		<!-- LATIN SMALL LETTER E WITH OGONEK -->
<!ENTITY ctlig "&#xEEC5;">		<!-- LATIN SMALL LIGATURE CT -->
<!ENTITY punctinter "&#xF160;">		<!-- PUNCTUS INTERROGATIVUS -->
<!ENTITY et "&#x204A;">		<!-- TIRONIAN SIGN ET -->
<!ENTITY ET "&#xF142;">		<!-- LATIN ABBREVIATION SIGN CAPITAL ET -->
<!ENTITY slongtlig "&#xFB05;">		<!-- LATIN SMALL LIGATURE LONG S T -->
<!ENTITY cross "&#x271D;">		<!-- LATIN CROSS -->
<!ENTITY eogonacute "&#xE499;">		<!-- LATIN SMALL LETTER E WITH OGONEK AND ACUTE -->
<!ENTITY hstrok "&#x0127;">		<!-- LATIN SMALL LETTER H WITH STROKE -->
<!ENTITY Lstrok "&#x0141;">		<!-- LATIN CAPITAL LETTER L WITH STROKE -->
<!ENTITY lstrok "&#x0142;">		<!-- LATIN SMALL LETTER L WITH STROKE -->
<!ENTITY sgldr "&#x2024;">		<!-- ONE DOT LEADER -->
<!ENTITY bacute "&#xE444;">		<!-- LATIN SMALL LETTER B WITH ACUTE -->
<!ENTITY us "&#x1DD2;">		<!-- COMBINING US ABOVE -->
<!ENTITY ndot "&#x1E45;">		<!-- LATIN SMALL LETTER N WITH DOT ABOVE -->
<!ENTITY rdot "&#x1E59;">		<!-- LATIN SMALL LETTER R WITH DOT ABOVE -->
<!ENTITY acute "&#x00B4;">		<!-- ACUTE ACCENT -->
<!ENTITY wavylin "&#xF1F9;">		<!-- WAVY LINE -->
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:ech="http://echoe.uni-goettingen.de/ns/1.0" xmlns:functx="http://www.functx.com">
<xsl:import href="functx-1.0-doc-2007-01.xsl"/>
<!-- This stylesheet was written by Paul S. Langeslag of the Medieval Studies section in the Department of English, University of Göttingen for the Electronic Corpus of Homilies in Old English (ECHOE) project 2024. -->

 <xsl:output method="text" encoding="utf-8"/>

<xsl:strip-space elements="*"/>

<xsl:param name="linerefs"/>

<xsl:template match="/">
    		<xsl:for-each select="tei:TEI">
     			<xsl:apply-templates select="tei:text"/>
			</xsl:for-each>
 </xsl:template>

<xsl:template match="tei:teiHeader">
</xsl:template>

 <xsl:template match="tei:text">
	<!-- print item title -->
	 <xsl:text>## </xsl:text><xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:idno[@type = 'echoe']"/><xsl:text>: </xsl:text><xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type = 'main']"/><xsl:text> in </xsl:text><xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:msName"/><xsl:text>&#xa;&#xa;</xsl:text>
	 <xsl:choose>
	 	<xsl:when test="/tei:TEI/tei:teiHeader/tei:profileDesc/tei:settingDesc/tei:setting/tei:p/text() = 'Unspecified'">
			<xsl:text>&#62; Unspecified occasion&#xa;&#xa;</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>&#62; </xsl:text><xsl:value-of select="/tei:TEI/tei:teiHeader/tei:profileDesc/tei:settingDesc/tei:setting/tei:p/text()"/><xsl:text>&#xa;&#xa;</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
	 <xsl:apply-templates/>
 </xsl:template>

<xsl:template match="comment()"/>

 <xsl:template match="tei:note">
 </xsl:template>

 <xsl:template match="tei:pb">
 </xsl:template>

 <xsl:template match="tei:cb">
 </xsl:template>

 <!--LINE BEGINNING: ignore-->
<xsl:template match="tei:lb">
 </xsl:template>

 <!--PARAGRAPH/ARBITRARY BLOCK: print a blank line-->
 <xsl:template match="tei:ab|tei:p">
	 <xsl:text>\</xsl:text>
	 <xsl:apply-templates/>
	 <xsl:text>&#xa;</xsl:text>
 </xsl:template>

 <!-- TEI:W: WORD ELEMENTS -->
 <xsl:template match="tei:w">
	<xsl:if test="not(ancestor::tei:add[starts-with(@xml:id, 'undo')]) and not(ancestor::tei:add and ancestor::*[starts-with(@xml:id, 'undo')]) and not(parent::tei:seg[starts-with(@xml:id, 'undo')])">
	 	<xsl:apply-templates/>
		<xsl:if test="not(@part = 'I') and not(@part = 'M')">
			<xsl:text> </xsl:text>
		</xsl:if>
	</xsl:if>
 </xsl:template>

 <!--HEADINGS are followed by two newlines -->
 <xsl:template match="tei:head">
	 <xsl:text>### </xsl:text><xsl:apply-templates/><xsl:text>&#xa;&#xa;</xsl:text>
 </xsl:template>

 <!--TRAILERS are followed by two newlines -->
 <xsl:template match="tei:trailer">
	 <xsl:text>### </xsl:text><xsl:apply-templates/><xsl:text>&#xa;&#xa;</xsl:text>
 </xsl:template>

 
 <!-- @INTERP -->
 <xsl:template match="tei:div">
      <xsl:apply-templates/>
 </xsl:template>

 <!--CHOICE-->
 <xsl:template match="tei:choice">
  <xsl:apply-templates/> 
 </xsl:template>

 <!-- ABBREVIATION -->
 <xsl:template match="tei:abbr">
 </xsl:template>

 <!-- ABBREVIATION MARKER -->
 <xsl:template match="tei:am">
 </xsl:template>

 <!-- EXPAN: This template specifies whether to display the content of the expan element. -->
 <xsl:template match="tei:expan">
     <xsl:apply-templates/>
 </xsl:template>

 <!-- EX: This template specifies whether and how to display the content of the ex element. -->
 <xsl:template match="tei:ex">
    <xsl:apply-templates/>
 </xsl:template>

 <!-- ADD: prints scribal and medieval additions, excluding glosses.  -->
 <xsl:template match="tei:add">
   <xsl:if test="not(@type = 'gloss') and not(starts-with(@xml:id, 'undo')) and not(ancestor::*[starts-with(@xml:id, 'undo')])">
	<xsl:apply-templates/>
   </xsl:if>
 </xsl:template>

 <!-- DEL: omits scribal and medieval deletions, except where <del> indicates a glossed item. -->
 <xsl:template match="tei:del">
	 <xsl:choose>
	 	<xsl:when test="preceding-sibling::tei:add/@type = 'gloss' or following-sibling::tei:add/@type = 'gloss' or @ana = 'optional' or starts-with(@xml:id, 'undo') or ancestor::*[starts-with(@xml:id, 'undo')]">
	<xsl:apply-templates/>
   </xsl:when>
   <xsl:otherwise>
   <xsl:if test="parent::tei:s and position() = 1 and (position() = last() or (position() = last()-1 and following-sibling::* = tei:lb))">
	<xsl:text>(erased)</xsl:text>
   </xsl:if>
   </xsl:otherwise>
   </xsl:choose>
 </xsl:template>

<!-- UNCLEAR: rendered normally -->
 <xsl:template match="tei:unclear">
    <xsl:apply-templates/>
 </xsl:template>

<!-- SUPPLIED: rendered normally -->
 <xsl:template match="tei:supplied">
    <xsl:apply-templates/>
 </xsl:template>

<!-- SURPLUS: ignored -->
 <xsl:template match="tei:surplus">
 </xsl:template>

 <xsl:template match="tei:sic">
 </xsl:template>

 <xsl:template match="tei:corr">
	    <xsl:apply-templates/>
 </xsl:template>

 <!-- ORIG: ignored -->
 <xsl:template match="tei:orig">
 </xsl:template>

 <!-- REG: displayed -->
 <xsl:template match="tei:reg">
	    <xsl:apply-templates/>
 </xsl:template>

<!--SEG[@type='transpose']: reorder! -->

 <xsl:template match="tei:seg">
	<xsl:choose>
		<xsl:when test="@type = 'transpose'">
			<xsl:apply-templates>
				<xsl:sort select="@ana"/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates/>
		</xsl:otherwise>
	</xsl:choose>
 </xsl:template>

<!--GAP: ignored -->

 <xsl:template match="tei:gap">
 </xsl:template>

<!--SPACE: ignored-->

 <xsl:template match="tei:space">
 </xsl:template>

<!--SENTENCES: if $linerefs true print one to a line with number, else number in text block -->
  <xsl:template match="tei:s">
	<xsl:choose>
		<xsl:when test="$linerefs = 'true'">
			<xsl:text>(</xsl:text><xsl:value-of select="substring-after(substring-after(@xml:id, '.'), '.')"/><xsl:text>) </xsl:text>
			<xsl:apply-templates/>
			<xsl:text>&#xa;</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>(</xsl:text><xsl:value-of select="substring-after(substring-after(@xml:id, '.'), '.')"/><xsl:text>) </xsl:text>
			<xsl:apply-templates/>
		</xsl:otherwise>
	</xsl:choose>
 </xsl:template>

 <!-- TEI:FW: Running headers and catchwords are omitted -->
 <xsl:template match="tei:fw">
 </xsl:template>

<!--INTERP-->

 <xsl:template match="tei:interp">
 </xsl:template>

<!--The following template uses a custom recursive implementation of the XSLT 2.0 function `replace` to normalize features. It requires for the functx namespace to be loaded and library to be imported. -->
 <xsl:variable name="plainSic" select="('á', 'ǽ', 'é', 'í', 'ó', 'ú', 'ý', 'ẏ', '&ydotacute;', '&combacute;', 'ſ', '&slongdes;', 'ƿ', 'Ƿ', '\n\s*', 'ß', 'ä', '\s·\s', '·', '\s', '', '⁊', '', '&et;', '&ET;', '-', '&thornbarslash;', '&THORNbarslash;', '&ilong;', 'Ẏ', '\s\s', '\s·\n\s*', '\s&punctelev;', '\s&punctelevdiag;', '\s&middot;', '\s&punctvers;', '\s&punctflex;', '\s&posit;', '\s&punctposit;', '\s&colmidcomposit;', '\s&lozengedot;', '\s&renvoi;', '\s&tridotright;', '', '&punctinter;', '&orrotlig;', '&rrot;', ' :', 'Á', 'Ǽ', 'É', 'Í', 'Ó', 'Ú', 'Ý', '', '&ogon;', '', '&ctlig;', 'ę', 'Ę', '&eogon;', '&Eogon;', 'Ä', '&amp;', '&punctelev;', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'Æ', 'Þ', 'Ð', '&acute;', '&posit;', '&bidotscomposit;', ':', '&colmidcomposit;', '&nbsp;', '&punctelevdiag;', '&punctposit;', '&dblldr;', '&est;', '&tridotsupw;', '&tridotdw;', '&tridotright;', '&gt;', '\.', '&slongtlig;', '&cross;', 'ô', '&eogonacute;', '&tld;', ';', '&sgldr;', '&bacute;', '&lstrok;\s', 'û', 'î', '&us;', '&tridotscomposit;', '&ndot;', '&rdot;', '&wavylin;', '', '&renvoi;', ',')"/>
 <xsl:variable name="plainSubst" select="('a', 'æ', 'e', 'i', 'o', 'u', 'y', 'y', 'y', '', 's', 's', 'w', 'w', '', 'y', 'a', ' ', '', '', '', 'and', 'and', 'and', 'and', '', 'þ', 'þ', 'i', 'y', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'or', 'r', ' ', 'a', 'æ', 'e', 'i', 'o', 'u', 'y', 'u', '', 'ct', 'ct', 'æ', 'æ', 'æ', 'æ', 'a', 'et', '', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'u', 'w', 'x', 'y', 'z', 'æ', 'þ', 'ð', '', '', '', '', '', ' ', '', '', '', '', '', '', '', '', '', 'st', '', 'o', 'æ', '', '', '', 'b', '', 'u', 'i', '', '', 'n', 'r', '', '', '', '')"/>
 <xsl:variable name="latinSubst" select="('a', 'æ', 'e', 'i', 'o', 'u', 'y', 'y', 'y', '', 's', 's', 'w', 'w', '', 'y', 'a', ' ', '', '', '', 'et', 'et', 'et', 'et', '', 'þ', 'þ', 'i', 'y', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'or', 'r', ' ', 'a', 'æ', 'e', 'i', 'o', 'u', 'y', 'u', '', 'ct', 'ct', 'æ', 'æ', 'æ', 'æ', 'a', 'et', '', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'u', 'w', 'x', 'y', 'z', 'æ', 'þ', 'ð', '', '', '', '', '', ' ', '', '', '', '', '', '', '', '', '', 'st', '', 'o', 'æ', '', '', '', 'b', '', 'u', 'i', '', '', 'n', 'r', '', '', '', '')"/>
 <xsl:template match="text()">
  <xsl:choose>
	<xsl:when test="ancestor::*[*]/@xml:lang='la'">
     <xsl:value-of select="functx:replace-multi(.,$plainSic,$latinSubst)"/>
	</xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="functx:replace-multi(.,$plainSic,$plainSubst)"/>
	</xsl:otherwise>
  </xsl:choose>
 </xsl:template>
</xsl:stylesheet>
