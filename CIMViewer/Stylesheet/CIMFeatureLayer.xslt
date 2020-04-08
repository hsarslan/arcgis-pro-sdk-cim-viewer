<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:output method="html" doctype-public="about:legacy-compat" encoding="UTF-8" indent="yes"/>
	<xsl:strip-space elements="*"/>
	<xsl:template match="/">
		<html>
			<body>
				<style type="text/css">* { font-family: arial, helvetica, "sans serif" }
					  td { font-family: arial, helvetica, "sans serif"; font-size: 10pt }
					  .blurb { border: 1px solid green; font-size: 10pt; padding: 5px; font-weight: bold; font-style: italic;}
					  .blurbcell { border: 1px solid green; font-size: 10pt; text-align: left; padding: 5px; }
					  .blurbcellCenter { border: 1px solid green; font-size: 10pt; text-align: center; padding: 5px; }
					  a { text-decoration: none; color: green; }
					  .headline { width: 100%; text-align: center }
					  .navlinks { background-color: #EEEEEE }
					  .gossipcell { font-size: 10pt; }
					  .admincell { text-align: center; font-size: 8pt; }
					  .bottomrow { border-top: 2px solid black; margin-top: 50px }
					  .rightcell { border-left: 1px solid black; padding-left: 10px; vertical-align: top }</style>
				<h2>
					<xsl:value-of select="CIMFeatureLayer/Name"/>
				</h2>
				<xsl:apply-templates select="CIMFeatureLayer"/>
				
				<xsl:apply-templates select="CIMFeatureLayer/FeatureTable"/>
				
			</body>
		</html>
	</xsl:template>
	<!--                              -->
	<!--  TEMPLATE Symbol Picture     -->
	<!--                              -->
	<xsl:template match="picture">
		<img  margin-left= "auto" margin-right= "auto" src="data:image/png;base64,{.}"/>
	</xsl:template>
	<!--                              -->
	<!--  TEMPLATE FeatureLayers        -->
	<!--                              -->
	<xsl:template match="CIMFeatureLayer">
		<h2><a>
		<xsl:attribute name="NAME">FL_<xsl:value-of select="Name" /></xsl:attribute>
		Feature Layer: <xsl:value-of select="Name"/>
		</a></h2>
		<h3>General Information</h3>
		<table cellSpacing="0" cellPadding="0" width="100%" border="1px solid green">
			<tr>
				<td class="blurb" width="25%">Name</td>
				<td colspan="5" class="blurbcell">
					<xsl:value-of select="Name"/>
				</td>
			</tr>
			<tr>
				<td class="blurb">Description</td>
				<td class="blurbcell" colspan="5">
					<xsl:value-of select="Description"/>
				</td>
			</tr>
			<tr>
				<br/>
			</tr>
			<tr>
				<td class="blurb" colspan="1">Feature Class Name</td>
				<td class="blurbcell" colspan="2">
					<xsl:value-of select="FeatureTable/DataConnection/Dataset"/>
				</td>
				<td class="blurb" colspan="2">Alias</td>
				<td class="blurbcell" colspan="2">???</td>
			</tr>
			<tr>
				<td class="blurb" colspan="1">Feature Dataset Name</td>
				<td class="blurbcell" colspan="2">
					<xsl:value-of select="FeatureTable/DataConnection/FeatureDataset"/>
				</td>
				<td class="blurb">Dataset Type</td>
				<td class="blurbcell" colspan="2">
					<xsl:apply-templates select="FeatureTable/DataConnection/DatasetType"/>
				</td>
			</tr>
			<tr>
				<td class="blurb">Definition Expression</td>
				<td class="blurbcell" colspan="5">
					<xsl:value-of select="FeatureTable/DefinitionExpression"/>
				</td>
			</tr>
			<tr>
				<td class="blurb" colspan="6">Display Property</td>
			</tr>
			<tr>
				<td class="blurb">Min Scale</td>
				<td class="blurbcell" colspan="2">
					<xsl:value-of select="format-number(number(MinScale),'1:###,###')"/>
				</td>
				<td class="blurb">Max Scale</td>
				<td class="blurbcell" colspan="2">
					<xsl:value-of select="format-number(number(MaxScale),'1:###,###')"/>
				</td>
			</tr>
			<tr>
				<td class="blurb" width="20%">Show Legends</td>
				<td class="blurbcell" width="13%">
					<xsl:value-of select="ShowLegends"/>
				</td>
				<td class="blurb" width="20%">Transparency</td>
				<td class="blurbcell" width="13%">
					<xsl:value-of select="Transparency"/>
				</td>
				<td class="blurb" width="20%">Default Visibility</td>
				<td class="blurbcell" width="14%">
					<xsl:value-of select="Visibility"/>
				</td>
			</tr>
			<tr>
				<td class="blurb" width="20%">Selectable</td>
				<td class="blurbcell" width="13%">
					<xsl:value-of select="Selectable"/>
				</td>
				<td class="blurb" width="20%">Scale Symbols</td>
				<td class="blurbcell" width="13%">
					<xsl:value-of select="ScaleSymbols"/>
				</td>
				<td class="blurb" width="20%">Snappable</td>
				<td class="blurbcell" width="14%">
					<xsl:value-of select="Snappable"/>
				</td>
			</tr>
		</table>
		<h3>Label Information</h3>
		<table cellSpacing="0" cellPadding="0" width="100%" border="1px solid green">
			<xsl:for-each select="LabelClasses/CIMLabelClass">
				<tr>
					<td class="blurb" width="25%">Name</td>
					<td class="blurbcell">
						<xsl:value-of select="Name"/>
					</td>
					<td class="blurb" width="25%">Visibility</td>
					<td class="blurbcell">
						<xsl:value-of select="Visibility"/>
					</td>
				</tr>
				<tr>
					<td class="blurb">Minimum Scale</td>
					<td class="blurbcell">
						<xsl:value-of select="format-number(number(MinimumScale),'1:###,###')"/>
					</td>
					<td class="blurb">Maximum Scale</td>
					<td class="blurbcell">
						<xsl:value-of select="format-number(number(MaximumScale),'1:###,###')"/>
					</td>
				</tr>
				<tr>
					<td class="blurb">Where Clause</td>
					<td class="blurbcell" colspan="3">
						<xsl:value-of select="WhereClause"/>
					</td>
				</tr>
				<tr>
					<td class="blurb">Expression</td>
					<td class="blurbcell" colspan="3">
						<xsl:value-of select="Expression"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<h3>Symbology Information</h3>
		<table cellSpacing="0" cellPadding="0" width="100%" border="1px solid green">
			<xsl:choose>
				<xsl:when test="Renderer/@xsi:type='typens:CIMUniqueValueRenderer'">
					<xsl:apply-templates select="Renderer/Groups"/>
				</xsl:when>
				<xsl:when test="Renderer/@xsi:type='typens:CIMSimpleRenderer'">
					<xsl:apply-templates select="Renderer/Symbol"/>
				</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>

		</table>
	</xsl:template>
	<!--                              -->
	<!--  TEMPLATE FeatureTable       -->
	<!--                              -->
	<xsl:template match="FeatureTable">
		<h3>Feature Table Definition</h3>
		<table cellSpacing="0" cellPadding="0" width="100%" border="1px solid green">
			<tr>
				<td class="blurb" width="25%">Dataset Name</td>
				<td class="blurbcell">
					<xsl:value-of select="DataConnection/Dataset"/>
				</td>
				<td class="blurb" width="25%">Type</td>
				<td class="blurbcell">
					<xsl:value-of select="@xsi:type"/>
				</td>
			</tr>
			<tr>
				<td class="blurb" width="25%">Definition Expression</td>
				<td class="blurbcell" colspan="3"><xsl:value-of select="DefinitionExpression"/></td></tr>
			<tr>
				<td class="blurb" width="25%">Display Field</td>
				<td class="blurbcell"><xsl:value-of select="DisplayField"/></td>
				<td class="blurb" width="25%">Editable</td>
				<td class="blurbcell"><xsl:value-of select="Editable"/></td>
			</tr>
			<tr>
				<td class="blurb" width="25%">Workspace Type</td>
				<td class="blurbcell"><xsl:value-of select="DataConnection/WorkspaceFactory"/></td>
				<td class="blurb" width="25%">Feature Dataset</td>
				<td class="blurbcell"><xsl:value-of select="DataConnection/FeatureDataset"/></td>
			</tr>
			<tr>
				<td class="blurb" width="25%">Connection String</td>
				<td class="blurbcell" colspan="3"><xsl:value-of select="DataConnection/WorkspaceConnectionString"/></td>
			</tr>
			</table>

			<table cellSpacing="0" cellPadding="0" width="100%" border="1px solid green">
				<tr>
					<td class="blurb" colspan="6">Field Descriptions</td>
				</tr>
				<tr>
					<td class="blurb" width="25%">Field Name</td>
					<td class="blurb" width="25%">Alias</td>
					<td class="blurb" width="25%">Visible</td>
				</tr>
			<xsl:for-each select="FieldDescriptions/CIMFieldDescription">
				<tr>
					<td class="blurbcell"><xsl:value-of select="FieldName"/></td>
					<td class="blurbcell"><xsl:value-of select="Alias"/></td>
					<td class="blurbcell"><xsl:value-of select="Visible"/></td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>

	<!--                              -->
	<!--  TEMPLATE Renderer-CIMSimpleRenderer    -->
	<!--                              -->
	<xsl:template match="Renderer/Symbol">
		<tr>
			<td class="blurb" width="25%">Type</td>
			<td class="blurbcell"><xsl:apply-templates select="../@xsi:type"/></td>
		</tr>
		<tr>
			<td class="blurb">Symbol</td>
			<td class="blurb">Label</td>
		</tr>
		<tr>
			<td class="blurbcellCenter"><xsl:apply-templates select="Symbol/picture"/></td>
			<td class="blurbcell"><xsl:value-of select="../Label"/></td>
		</tr>
		
	</xsl:template>
	<!--                              -->
	<!--  TEMPLATE Renderer-CIMUniqueValueRenderer    -->
	<!--                              -->
	<xsl:template match="Renderer/Groups">
		<tr>
			<td class="blurb" width="25%">Type</td>
			<td class="blurbcell"><xsl:apply-templates select="../@xsi:type"/></td>
		</tr>
		<tr>
			<td class="blurb" colspan="2">Default Symbol</td>
		</tr>
		<tr>
			<td class="blurb">Symbol</td>
			<td class="blurb">Label</td>
		</tr>
		<tr>
			<td class="blurbcellCenter"><xsl:apply-templates select="../DefaultSymbol/Symbol/picture"/></td>
			<td class="blurbcell"><xsl:value-of select="../DefaultLabel"/></td>
		</tr>
		<xsl:for-each select="CIMUniqueValueGroup">
			<tr>
				<td class="blurb" colspan="2">Unique Value Classes</td>
			</tr>
			<tr>
				<td class="blurb">Symbol</td>
				<td class="blurb">Label</td>
			</tr>
			<xsl:for-each select="Classes/CIMUniqueValueClass">
				<tr>
					<td class="blurbcellCenter">
						<xsl:apply-templates select="picture"/>
					</td>
					<td class="blurbcell">
						<xsl:value-of select="Label"/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	<!--                              -->
	<!--  ENUMERATOR RENDERERTYPE     -->
	<!--                              -->
	<xsl:template match="Renderer/@xsi:type">
		<xsl:choose>
			<xsl:when test=".='typens:CIMUniqueValueRenderer'">Unique Value Renderer</xsl:when>
			<xsl:when test=".='typens:CIMSimpleRenderer'">Simple Renderer</xsl:when>
			<xsl:otherwise>-</xsl:otherwise>
		</xsl:choose>
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
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="yes" url="file:///c:/Temp/New folder/madinah_layers/warehouses.xml" htmlbaseurl="" outputurl="" processortype="msxmldotnet" useresolver="no" profilemode="0"
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