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
				<h2>ArcGIS Document Report</h2>
				<table border="1">
					<tr bgcolor="#9acd32">
						<th>Name</th>
						<th>Description</th>
					</tr>
					<xsl:for-each select="CIMMap">
						<tr>
							<td>
								<xsl:value-of select="Name"/>
							</td>
							<td>
								<xsl:value-of select="Description"/>
							</td>
						</tr>
					</xsl:for-each>
				</table>
				<!--                     -->
				<!--  TABLE OF CONTENTS  -->
				<!--                     -->
				<HR/>
				<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#e0ffff" border="0">
					<TR>
						<TD colspan="2">
							<P align="center">Table Of Contents</P>
						</TD>
					</TR>
					
				</TABLE>
				<A href="#Top">Back to Top</A>

				<!--           -->
				<!--  GroupLayers  -->
				<!--           -->
				<xsl:if test="count(//CIMGroupLayer) &gt; 0">
					<HR/>
					<!--  Featurelayers HEARDER -->
					<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffc0cb" border="0">
						<TR>
							<TD>
								<P align="center">
									<A name="FL">Group Layers</A>
								</P>
							</TD>
						</TR>
					</TABLE>
					<BR/>
					<!--  Featurelayers SUMMARY -->
					<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#faebd7" border="0">
						<TR>
							<TD width="30%">
								<B>Group Layer Name</B>
							</TD>
							<TD width="70%">
								<B>Description</B>
							</TD>
						</TR>
						<xsl:for-each select="//CIMGroupLayer">
							<xsl:sort select="Name"/>
							<TR>
								<TD width="30%">
									<A>
										<xsl:attribute name="HREF">#GL_<xsl:value-of select="Name"/></xsl:attribute>
										<xsl:value-of select="Name"/>
									</A>
								</TD>
								<TD width="70%">
									<xsl:value-of select="Description"/>
								</TD>
							</TR>
						</xsl:for-each>
					</TABLE>
					<P><A href="#Top">Back to Top</A></P>
					<HR/>
				</xsl:if>
				<!--           -->
				<!--  Featurelayers  -->
				<!--           -->
				<xsl:if test="count(//CIMFeatureLayer) &gt; 0">
					<HR/>
					<!--  Featurelayers HEARDER -->
					<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffc0cb" border="0">
						<TR>
							<TD>
								<P align="center">
									<A name="FL">Feature Layers</A>
								</P>
							</TD>
						</TR>
					</TABLE>
					<BR/>
					<!--  Featurelayers SUMMARY -->
					<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#faebd7" border="0">
						<TR>
							<TD width="30%">
								<B>Feature Layer Name</B>
							</TD>
						</TR>
						<xsl:for-each select="//CIMFeatureLayer">
							<xsl:sort select="Name"/>
							<TR>
								<TD width="30%">
									<A>
										<xsl:attribute name="HREF">#FL_<xsl:value-of select="Name"/></xsl:attribute>
										<xsl:value-of select="Name"/>
									</A>
								</TD>
							</TR>
						</xsl:for-each>
					</TABLE>
					<P><A href="#Top">Back to Top</A></P>
					<HR/>
				</xsl:if>
				<!--           -->
				<!--  RasterLayers  -->
				<!--           -->
				<xsl:if test="count(//CIMRasterLayer) &gt; 0">
					<HR/>
					<!--  Featurelayers HEARDER -->
					<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffc0cb" border="0">
						<TR>
							<TD>
								<P align="center">
									<A name="RL">Raster Layers</A>
								</P>
							</TD>
						</TR>
					</TABLE>
					<BR/>
					<!--  Featurelayers SUMMARY -->
					<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#faebd7" border="0">
						<TR>
							<TD width="30%">
								<B>Raster Layer Name</B>
							</TD>
							<TD width="70%">
								<B>Description</B>
							</TD>
						</TR>
						<xsl:for-each select="//CIMRasterLayer">
							<xsl:sort select="Name"/>
							<TR>
								<TD width="30%">
									<A>
										<xsl:attribute name="HREF">#RL_<xsl:value-of select="Name"/></xsl:attribute>
										<xsl:value-of select="Name"/>
									</A>
								</TD>
								<TD width="70%">
									<xsl:value-of select="Description"/>
								</TD>
							</TR>
						</xsl:for-each>
					</TABLE>
					<P><A href="#Top">Back to Top</A></P>
					<HR/>
				</xsl:if>
				<!--           -->
				<!--  TiledServiceLayers  -->
				<!--           -->
				<xsl:if test="count(//CIMTiledServiceLayer) &gt; 0">
					<HR/>
					<!--  Featurelayers HEARDER -->
					<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffc0cb" border="0">
						<TR>
							<TD>
								<P align="center">
									<A name="TSL">Tiled Service Layers</A>
								</P>
							</TD>
						</TR>
					</TABLE>
					<BR/>
					<!--  Featurelayers SUMMARY -->
					<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#faebd7" border="0">
						<TR>
							<TD width="30%">
								<B>Tiled Service Layer Name</B>
							</TD>
							<TD width="70%">
								<B>Description</B>
							</TD>
						</TR>
						<xsl:for-each select="//CIMTiledServiceLayer">
							<xsl:sort select="Name"/>
							<TR>
								<TD width="30%">
									<A>
										<xsl:attribute name="HREF">#TSL_<xsl:value-of select="Name"/></xsl:attribute>
										<xsl:value-of select="Name"/>
									</A>
								</TD>
								<TD width="70%">
									<xsl:value-of select="Description"/>
								</TD>
							</TR>
						</xsl:for-each>
					</TABLE>
					<P><A href="#Top">Back to Top</A></P>
					<HR/>
				</xsl:if>
				<!--           -->
				<!--  DynamicServiceLayers  -->
				<!--           -->
				<xsl:if test="count(//CIMDynamicServiceLayer) &gt; 0">
					<HR/>
					<!--  Featurelayers HEARDER -->
					<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffc0cb" border="0">
						<TR>
							<TD>
								<P align="center">
									<A name="DSL">Dynamic Service Layers</A>
								</P>
							</TD>
						</TR>
					</TABLE>
					<BR/>
					<!--  Featurelayers SUMMARY -->
					<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#faebd7" border="0">
						<TR>
							<TD width="30%">
								<B>Dynamic Service Layer Name</B>
							</TD>
							<TD width="70%">
								<B>Description</B>
							</TD>
						</TR>
						<xsl:for-each select="//CIMDynamicServiceLayer">
							<xsl:sort select="Name"/>
							<TR>
								<TD width="30%">
									<A>
										<xsl:attribute name="HREF">#DSL_<xsl:value-of select="Name"/></xsl:attribute>
										<xsl:value-of select="Name"/>
									</A>
								</TD>
								<TD width="70%">
									<xsl:value-of select="Description"/>
								</TD>
							</TR>
						</xsl:for-each>
					</TABLE>
					<P><A href="#Top">Back to Top</A></P>
					<HR/>
				</xsl:if>
				<!--           -->
				<!--  Tables  -->
				<!--           -->
				<xsl:if test="count(//CIMStandaloneTable) &gt; 0">
					<HR/>
					<!--  Featurelayers HEARDER -->
					<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffc0cb" border="0">
						<TR>
							<TD>
								<P align="center">
									<A name="FL">Tables</A>
								</P>
							</TD>
						</TR>
					</TABLE>
					<BR/>
					<!--  Featurelayers SUMMARY -->
					<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#faebd7" border="0">
						<TR>
							<TD width="30%">
								<B>Table Name</B>
							</TD>
							<TD width="70%">
								<B>Description</B>
							</TD>
						</TR>
						<xsl:for-each select="//CIMStandaloneTable">
							<xsl:sort select="Name"/>
							<TR>
								<TD width="30%">
									<A>
										<xsl:attribute name="HREF">#ST_<xsl:value-of select="Name"/></xsl:attribute>
										<xsl:value-of select="Name"/>
									</A>
								</TD>
								<TD width="70%">
									<xsl:value-of select="Description"/>
								</TD>
							</TR>
						</xsl:for-each>
					</TABLE>
					<P><A href="#Top">Back to Top</A></P>
					<HR/>
				</xsl:if>
				<xsl:for-each select="CIMMap/Layers/String">
					<xsl:choose>
						<xsl:when test="CIMGroupLayer">
							<xsl:apply-templates select="CIMGroupLayer"/>
						</xsl:when>
						<xsl:when test="CIMFeatureLayer">
							<xsl:apply-templates select="CIMFeatureLayer"/>
						</xsl:when>
						<xsl:when test="CIMRasterLayer">
							<xsl:apply-templates select="CIMRasterLayer"/>
						</xsl:when>
						<xsl:when test="CIMTiledServiceLayer">
							<xsl:apply-templates select="CIMTiledServiceLayer"/>
						</xsl:when>
						<xsl:when test="CIMDynamicServiceLayer">
							<xsl:apply-templates select="CIMDynamicServiceLayer"/>
						</xsl:when>
						<xsl:otherwise></xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
				<xsl:for-each select="CIMMap/StandaloneTables/String">
					<xsl:apply-templates select="CIMStandaloneTable"/>
				</xsl:for-each>
			</body>
		</html>
	</xsl:template>

	<!--                              -->
	<!--  TEMPLATE StandaloneTables        -->
	<!--                              -->
	<xsl:template match="CIMStandaloneTable">
		<h2>
			<a>
				<xsl:attribute name="NAME">ST_<xsl:value-of select="Name"/></xsl:attribute>Table: <xsl:value-of select="Name"/></a>
		</h2>
		<h3>General Information</h3>
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
				<td class="blurb" width="25%">Display Field</td>
				<td class="blurbcell">
					<xsl:value-of select="DisplayField"/>
				</td>
				<td class="blurb" width="25%">Editable</td>
				<td class="blurbcell">
					<xsl:value-of select="Editable"/>
				</td>
			</tr>
			<tr>
				<td class="blurb" width="25%">Workspace Type</td>
				<td class="blurbcell">
					<xsl:value-of select="DataConnection/WorkspaceFactory"/>
				</td>
				<td class="blurb" width="25%">Feature Dataset</td>
				<td class="blurbcell">
					<xsl:value-of select="DataConnection/FeatureDataset"/>
				</td>
			</tr>
			<tr>
				<td class="blurb" width="25%">Connection String</td>
				<td class="blurbcell" colspan="3">
					<xsl:value-of select="DataConnection/WorkspaceConnectionString"/>
				</td>
			</tr>
		</table>
		<xsl:for-each select="FieldDescriptions">
			<table cellSpacing="0" cellPadding="0" width="100%" border="1px solid green">
				<tr>
					<td class="blurb" colspan="6">Field Descriptions</td>
					<br/>
				</tr>
				<tr>
					<td class="blurb" width="25%">Field Name</td>
					<td class="blurb" width="25%">Alias</td>
					<td class="blurb" width="25%">Visible</td>
				</tr>
				<xsl:for-each select="CIMFieldDescription">
					<tr>
						<td class="blurbcell">
							<xsl:value-of select="FieldName"/>
						</td>
						<td class="blurbcell">
							<xsl:value-of select="Alias"/>
						</td>
						<td class="blurbcell">
							<xsl:value-of select="Visible"/>
						</td>
					</tr>
				</xsl:for-each>
			</table>
		</xsl:for-each>
		<P><A href="#Top">Back to Top</A></P>
	</xsl:template>

	<!--                              -->
	<!--  TEMPLATE TiledServiceLayers        -->
	<!--                              -->
	<xsl:template match="CIMTiledServiceLayer">
		<h2>
			<a>
				<xsl:attribute name="NAME">TSL_<xsl:value-of select="Name"/></xsl:attribute>Tiled Service Layer: <xsl:value-of select="Name"/></a>
		</h2>
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
				<td class="blurb" colspan="1">Object Name</td>
				<td class="blurbcell" colspan="2">
					<xsl:value-of select="ServiceConnection/ObjectName"/>
				</td>
				<td class="blurb">Object Type</td>
				<td class="blurbcell" colspan="2">
					<xsl:apply-templates select="ServiceConnection/ObjectType"/>
				</td>
			</tr>
			<tr>
				<td class="blurb">Service URL</td>
				<td class="blurb" colspan="5">
					<xsl:value-of select="ServiceConnection/URL"/>
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
		</table>
		<P><A href="#Top">Back to Top</A></P>
	</xsl:template>
	<!--                              -->
	<!--  TEMPLATE DynamicServiceLayers        -->
	<!--                              -->
	<xsl:template match="CIMDynamicServiceLayer">
		<h2>
			<a>
				<xsl:attribute name="NAME">DSL_<xsl:value-of select="Name"/></xsl:attribute>Tiled Service Layer: <xsl:value-of select="Name"/></a>
		</h2>
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
				<td class="blurb" colspan="1">Object Name</td>
				<td class="blurbcell" colspan="2">
					<xsl:value-of select="ServiceConnection/ObjectName"/>
				</td>
				<td class="blurb">Object Type</td>
				<td class="blurbcell" colspan="2">
					<xsl:apply-templates select="ServiceConnection/ObjectType"/>
				</td>
			</tr>
			<tr>
				<td class="blurb">Service URL</td>
				<td class="blurb" colspan="5">
					<xsl:value-of select="ServiceConnection/URL"/>
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
		</table>
		<P><A href="#Top">Back to Top</A></P>
	</xsl:template>
	<!--                              -->
	<!--  TEMPLATE RasterLayers       -->
	<!--                              -->
	<xsl:template match="CIMRasterLayer">
		<h2>
			<a>
				<xsl:attribute name="NAME">RL_<xsl:value-of select="Name"/></xsl:attribute>Raster Layer: <xsl:value-of select="Name"/></a>
		</h2>
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
				<td class="blurb" colspan="1">Dataset Name</td>
				<td class="blurbcell" colspan="2">
					<xsl:value-of select="DataConnection/Dataset"/>
				</td>
				<td class="blurb">Dataset Type</td>
				<td class="blurbcell" colspan="2">
					<xsl:apply-templates select="DataConnection/DatasetType"/>
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
		</table>
		<P><A href="#Top">Back to Top</A></P>
	</xsl:template>

	<!--                              -->
	<!--  TEMPLATE GroupLayers        -->
	<!--                              -->
	<xsl:template match="CIMGroupLayer">
		<h2>
			<a>
				<xsl:attribute name="NAME">GL_<xsl:value-of select="Name"/></xsl:attribute>Group Layer: <xsl:value-of select="Name"/></a>
		</h2>
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
		</table>
		<h3>Layers</h3>
		<table cellSpacing="0" cellPadding="0" width="100%" border="1px solid green">
			<xsl:for-each select="Layers/String">
				<tr>
					<td class="blurbcell">
						<a>
							<xsl:attribute name="HREF">#FL_<xsl:value-of select="CIMFeatureLayer/Name"/></xsl:attribute>
							<xsl:value-of select="CIMFeatureLayer/Name"/>
							<xsl:value-of select="CIMGroupLayer/Name"/>
						</a>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<P><A href="#Top">Back to Top</A></P>
		<xsl:for-each select="Layers/String">
			<xsl:apply-templates select="CIMGroupLayer"/>
			<xsl:apply-templates select="CIMFeatureLayer"/>
		</xsl:for-each>
		<P><A href="#Top">Back to Top</A></P>
	</xsl:template>
	<!--                              -->
	<!--  TEMPLATE FeatureLayers        -->
	<!--                              -->
	<xsl:template match="CIMFeatureLayer">
		<h2>
			<a>
				<xsl:attribute name="NAME">FL_<xsl:value-of select="Name"/></xsl:attribute>Feature Layer: <xsl:value-of select="Name"/></a>
		</h2>
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
		<xsl:apply-templates select="FeatureTable"/>
		<P><A href="#Top">Back to Top</A></P>
	</xsl:template>

	<!--                              -->
	<!--  TEMPLATE Symbol Picture     -->
	<!--                              -->
	<xsl:template match="picture">
		<img margin-left="auto" margin-right="auto" src="data:image/png;base64,{.}"/>
	</xsl:template>
	<!--                              -->
	<!--  TEMPLATE Renderer-CIMSimpleRenderer    -->
	<!--                              -->
	<xsl:template match="Renderer/Symbol">
		<tr>
			<td class="blurb" width="25%">Type</td>
			<td class="blurbcell">
				<xsl:apply-templates select="../@xsi:type"/>
			</td>
		</tr>
		<tr>
			<td class="blurb">Symbol</td>
			<td class="blurb">Label</td>
		</tr>
		<tr>
			<td class="blurbcellCenter">
				<xsl:apply-templates select="Symbol/picture"/>
			</td>
			<td class="blurbcell">
				<xsl:value-of select="../Label"/>
			</td>
		</tr>
	</xsl:template>
	<!--                              -->
	<!--  TEMPLATE Renderer-CIMUniqueValueRenderer    -->
	<!--                              -->
	<xsl:template match="Renderer/Groups">
		<tr>
			<td class="blurb" width="25%">Type</td>
			<td class="blurbcell">
				<xsl:apply-templates select="../@xsi:type"/>
			</td>
		</tr>
		<tr>
			<td class="blurb" colspan="2">Default Symbol</td>
		</tr>
		<tr>
			<td class="blurb">Symbol</td>
			<td class="blurb">Label</td>
		</tr>
		<tr>
			<td class="blurbcellCenter">
				<xsl:apply-templates select="../DefaultSymbol/Symbol/picture"/>
			</td>
			<td class="blurbcell">
				<xsl:value-of select="../DefaultLabel"/>
			</td>
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
				<td class="blurbcell" colspan="3">
					<xsl:value-of select="DefinitionExpression"/>
				</td>
			</tr>
			<tr>
				<td class="blurb" width="25%">Display Field</td>
				<td class="blurbcell">
					<xsl:value-of select="DisplayField"/>
				</td>
				<td class="blurb" width="25%">Editable</td>
				<td class="blurbcell">
					<xsl:value-of select="Editable"/>
				</td>
			</tr>
			<tr>
				<td class="blurb" width="25%">Workspace Type</td>
				<td class="blurbcell">
					<xsl:value-of select="DataConnection/WorkspaceFactory"/>
				</td>
				<td class="blurb" width="25%">Feature Dataset</td>
				<td class="blurbcell">
					<xsl:value-of select="DataConnection/FeatureDataset"/>
				</td>
			</tr>
			<tr>
				<td class="blurb" width="25%">Connection String</td>
				<td class="blurbcell" colspan="3">
					<xsl:value-of select="DataConnection/WorkspaceConnectionString"/>
				</td>
			</tr>
		</table>
		<xsl:for-each select="FieldDescriptions">
			<table cellSpacing="0" cellPadding="0" width="100%" border="1px solid green">
				<tr>
					<td class="blurb" colspan="6">Field Descriptions</td>
					<br/>
				</tr>
				<tr>
					<td class="blurb" width="25%">Field Name</td>
					<td class="blurb" width="25%">Alias</td>
					<td class="blurb" width="25%">Visible</td>
				</tr>
				<xsl:for-each select="CIMFieldDescription">
					<tr>
						<td class="blurbcell">
							<xsl:value-of select="FieldName"/>
						</td>
						<td class="blurbcell">
							<xsl:value-of select="Alias"/>
						</td>
						<td class="blurbcell">
							<xsl:value-of select="Visible"/>
						</td>
					</tr>
				</xsl:for-each>
			</table>
		</xsl:for-each>
	</xsl:template>
	<!--                              -->
	<!--  Template FieldDescriptions     -->
	<!--                              -->
	<xsl:template match="FieldDescriptions">
		<table cellSpacing="0" cellPadding="0" width="100%" border="1px solid green">
			<tr>
				<td class="blurb" colspan="6">Field Descriptions</td>
			</tr>
			<tr>
				<td class="blurb" width="25%">Field Name</td>
				<td class="blurb" width="25%">Alias</td>
				<td class="blurb" width="25%">Visible</td>
			</tr>
			<xsl:for-each select="CIMFieldDescription">
				<tr>
					<td class="blurbcell">
						<xsl:value-of select="FieldName"/>
					</td>
					<td class="blurbcell">
						<xsl:value-of select="Alias"/>
					</td>
					<td class="blurbcell">
						<xsl:value-of select="Visible"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
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
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="yes" url="file:///c:/Temp/New folder/Madinah Layers.xml" htmlbaseurl="" outputurl="" processortype="msxmldotnet" useresolver="no" profilemode="0" profiledepth=""
		          profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal"
		          customvalidator="">
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