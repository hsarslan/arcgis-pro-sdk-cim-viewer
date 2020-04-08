<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:template match="/">
		<html>
			<body>
				<style type="text/css">
					  * { font-family: arial, helvetica, "sans serif" }
					  td { font-family: arial, helvetica, "sans serif"; font-size: 10pt }
					  .blurb { border: 1px solid green; font-size: 10pt; padding: 5px; font-weight: bold; font-style: italic;}
					  .blurbcell { border: 1px solid green; font-size: 10pt; text-align: left; padding: 5px; }
					  a { text-decoration: none; color: green; }
					  .headline { width: 100%; text-align: center }
					  .navlinks { background-color: #EEEEEE }
					  .gossipcell { font-size: 10pt; }
					  .admincell { text-align: center; font-size: 8pt; }
					  .bottomrow { border-top: 2px solid black; margin-top: 50px }
					  .rightcell { border-left: 1px solid black; padding-left: 10px; vertical-align: top } 
					        
				</style>
				<h2><xsl:value-of select="CIMGroupLayer/Name"/>
				</h2>
				<h3>General Information</h3>
				<table cellSpacing="0" cellPadding="0" width="100%" border="1px solid green">
					<tr>
						<td class="blurb" width="25%">Name</td>
						<td colspan="5" class="blurbcell"><xsl:value-of select="CIMGroupLayer/Name"/>
						</td>
					</tr>
					<tr>
						<td class="blurb">Description</td>
						<td class="blurbcell" colspan="5"><xsl:value-of select="CIMGroupLayer/Description"/>
						</td>
					</tr>
					<tr>
						<br/>
					</tr>
					<tr>
						<td class="blurb" colspan="6">Display Property</td>
					</tr>
					<tr>
						<td class="blurb">Min Scale</td>
						<td class="blurbcell" colspan="2"><xsl:value-of select="format-number(number(CIMGroupLayer/MinScale),'1:###,###')"/>
						</td>
						<td class="blurb">Max Scale</td>
						<td class="blurbcell" colspan="2"><xsl:value-of select="format-number(number(CIMGroupLayer/MaxScale),'1:###,###')"/>
						</td>
					</tr>
					<tr>
						<td class="blurb" width="20%">Show Legends</td>
						<td class="blurbcell" width="13%">
							<xsl:value-of select="CIMGroupLayer/ShowLegends"/>
						</td>
						<td class="blurb" width="20%">Transparency</td>
						<td class="blurbcell" width="13%">
							<xsl:value-of select="CIMGroupLayer/Transparency"/>
						</td>
						<td class="blurb" width="20%">Default Visibility</td>
						<td class="blurbcell" width="14%">
							<xsl:value-of select="CIMGroupLayer/Visibility"/>
						</td>
					</tr>
				</table>
				<h3>Layers</h3>
				<table cellSpacing="0" cellPadding="0" width="100%" border="1px solid green">
					<xsl:for-each select="CIMGroupLayer/Layers/String">
						<tr>
							<td class="blurbcell"><xsl:value-of select="."/></td>
						</tr>
					</xsl:for-each>
				</table>
			</body>
		</html>
	</xsl:template>
	<!--                              -->
	<!--  ENUMERATOR ESRIDATASETTYPE  -->
	<!--                              -->
	<xsl:template match="DatasetType">
		<xsl:choose>
			<xsl:when test=".='esriDTFeatureClass'">FeatureClass</xsl:when>
			<xsl:when test=".='esriDTTable'">Table</xsl:when>
			<xsl:otherwise>-</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--                               -->
  <!--  ENUMERATOR ESRIFEATURETYPE  -->
  <!--                               -->
  <xsl:template match="FeatureType">
    <xsl:choose>
      <xsl:when test=".='esriFTSimple'">Simple</xsl:when>
      <xsl:when test=".='esriFTSimpleJunction'">Simple Junction</xsl:when>
      <xsl:when test=".='esriFTSimpleEdge'">Simple Edge</xsl:when>
      <xsl:when test=".='esriFTComplexJunction'">Complex Junction</xsl:when>
      <xsl:when test=".='esriFTComplexEdge'">Complex Edge</xsl:when>
      <xsl:when test=".='esriFTAnnotation'">Annotation</xsl:when>
      <xsl:when test=".='esriFTDimension'">Dimension</xsl:when>
      <xsl:when test=".='esriFTRasterCatalogItem'">Dimension</xsl:when>
      <xsl:otherwise>-</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="yes" url="file:///c:/Temp/New folder/madinah_layers/admin_boundaries.xml" htmlbaseurl="" outputurl="" processortype="msxmldotnet" useresolver="no" profilemode="0"
		          profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no"
		          validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="true"/>
			<advancedProp name="bGenerateByteCode" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->