	class IFCRELASSOCIATESMATERIAL
  def initialize1(args=[])			
	attach_to_obj
	$depend_on={} if $depend_on == nil
    $depend_on[@relatedObjects.to_s.gsub("(","").gsub(")","")] ="" if $depend_on[@relatedObjects.to_s.gsub("(","").gsub(")","")]== nil
    $depend_on[@relatedObjects.to_s.gsub("(","").gsub(")","")] += "#" + @line_id.to_s
	super
  end
  
  def attach_to_obj
	#doc:<div class='documentaion' >This method will be called automatically if this extension is loaded (the class IfcRelAssociatesMaterial is selected and the caching is disabled)
	#doc:It links the material properties with the associated objects as new attributes to be used in reports and quires as fellow:
	#doc:<ul><li>IfcMaterial</li><ul><li>ext_material_name</li></ul><li>IfcMaterialList</li><ul><li>ext_materiallist_name</li><li>ext_materiallist_count</li></ul><li>IfcMaterialLayer</li><li>IfcMaterialLayerSet</li><li>IfcMaterialLayerSetUsage</li><ul> <li><i>ext_MaterialLayerSetUsage_material_name</i></li><li><i>ext_MaterialLayerSetUsage_layer_count</i></li><li><i>ext_MaterialLayerSetUsage_total_thickness</i></li><li><i>ext_MaterialLayerSetUsage_layerSetName</i></li><li><i>ext_MaterialLayerSetUsage_OffsetFromReferenceLine</i></li></ul></ul>	
	#doc:</div>
	@relatedObjects.to_s.toIfcObject.each {|k,v|		
		relatingMat = @relatingMaterial.to_s.to_obj
		relatingMat.attach_to_obj(v)	if relatingMat.respond_to?("attach_to_obj")		
		}	
	end
	
	def qto			
	#doc:<div class='documentaion' >This method can be used to create a QuantityTakeOff report.</br>
	#doc:Beside selecting IfcRelAssociatesMaterial class we have to select the IfcRelDefinedByProperties,IfcRelDefinesByType classes as well.
	#doc:The following attributes will be used for calculations:<ul><li>Width</li><li>Height</li><li>Length</li><li>Perimeter</li><li>Volume,NetVolume, GrossVolume</li><li>Area, GrossArea ,GrossSideArea, NetSideArea, GrossFootprintArea,NetFootprintArea, NetWallArea, GrossWallArea</li></ul>
	#doc:</div>
	sum_area = 0
	sum_volume = 0
	@relatingMaterial.toIfcObject
	@relatedObjects.toIfcObject
	matObj=$ifcObjects[@relatingMaterial.to_s.sub("#","").to_i]			
	res = ""
	
	table_header="<table width='100%'>\n<tr>\n<th>Item</th>\n<th>Name</th>\n<th>globalId</th>\n<th>Quantities</th>\n<th colspan=5>Materials</th>\n</tr>"
	res = res + table_header
	hasIfcBuildingElement = false
	@relatedObjects.to_s.delete("(").delete(")").gsub(",","").split("#").each { |o|	
	obj=$ifcObjects[o.to_i]				
	next if obj == nil 		
	next if not obj.is_a?(IFCBUILDINGELEMENT)
	hasIfcBuildingElement = true
	
	
	width = obj.instance_variable_get(("@ext_width").to_sym).to_s
	height = obj.instance_variable_get(("@ext_height").to_sym).to_s
	length = obj.instance_variable_get(("@ext_length").to_sym).to_s	
	
	grossVolume = obj.instance_variable_get(("@ext_grossVolume").to_sym).to_s
	
	volume = obj.instance_variable_get(("@ext_volume").to_sym)
	sum_volume += volume.to_f  if volume.to_s != ""
	
	area = obj.instance_variable_get(("@ext_area").to_sym).to_s
	sum_area += area.to_f if area.to_s != ""
	
	netVolume = obj.instance_variable_get(("@ext_netVolume").to_sym).to_s
	
	#TODO: GrossCeilingArea NetCeilingArea GrossPrimeter NetPrimeter GrossSectionArea OuterSurfaceArea
	netArea = obj.instance_variable_get(("@ext_netArea").to_sym).to_s
	grossSideArea = obj.instance_variable_get(("@ext_grossSideArea").to_sym).to_s
	netSideArea = obj.instance_variable_get(("@ext_netSideArea").to_sym).to_s
	netSideAreaLeft = obj.instance_variable_get(("@ext_netSideAreaLeft").to_sym).to_s
	netSideAreaRight = obj.instance_variable_get(("@ext_netSideAreaRight").to_sym).to_s
	grossFootprintArea = obj.instance_variable_get(("@ext_grossFootprintArea").to_sym).to_s
	netFootprintArea = obj.instance_variable_get(("@ext_netFootprintArea").to_sym).to_s		
	left_face_area =  obj.instance_variable_get(("@ext_left_face_area").to_sym).to_s
	right_face_area=  obj.instance_variable_get(("@ext_right_face_area").to_sym).to_s
	horizontal_area=  obj.instance_variable_get(("@ext_horizontal_area").to_sym).to_s
	
	perimeter = obj.instance_variable_get(("@ext_perimeter").to_sym).to_s
	netWallArea = obj.instance_variable_get(("@ext_netWallArea").to_sym).to_s
	grossWallArea = obj.instance_variable_get(("@ext_grossWallArea").to_sym).to_s
	netFloorArea= obj.instance_variable_get(("@ext_netFloorArea").to_sym).to_s
	grossFloorArea= obj.instance_variable_get(("@ext_grossFloorArea").to_sym).to_s
	
	thickness= obj.instance_variable_get(("@ext_thickness").to_sym).to_s
	default_Thickness= obj.instance_variable_get(("@ext_default_Thickness").to_sym).to_s
	
	if obj.respond_to?('volume') then volume_geometry=obj.volume.to_s  else volume_geometry="" end
	if obj.respond_to?('area') then area__geometry=obj.area.to_s else area__geometry="" end
	if obj.respond_to?('area_side') then area_side__geometry=obj.area_side.to_s else area_side__geometry="" end
	
	quantity_table="<table>"
	quantity_table += "<tr><td>length</td><td>" + length + "</td></tr>" if length != ""
	quantity_table += "<tr><td>width</td><td>" + width + "</td></tr>" if width != ""		
	quantity_table += "<tr><td>height</td><td>" + height + "</td></tr>" if height != ""		
	quantity_table += "<tr><td>Volume</td><td>" + volume.to_s + "</td></tr>" if volume.to_s != ""
	quantity_table += "<tr><td>grossVolume</td><td>" + grossVolume + "</td></tr>" if grossVolume != ""
	quantity_table += "<tr><td>NetVolume</td><td>" + netVolume + "</td></tr>" if netVolume != ""		
	quantity_table += "<tr><td>Area</td><td>" + area + "</td></tr>" if area != ""
	quantity_table += "<tr><td>netArea</td><td>" + netArea + "</td></tr>" if netArea != ""
	quantity_table += "<tr><td>grossSideArea</td><td>" + grossSideArea + "</td></tr>" if grossSideArea != ""
	quantity_table += "<tr><td>netSideArea</td><td>" + netSideArea + "</td></tr>" if netSideArea != ""
	quantity_table += "<tr><td>netSideAreaLeft</td><td>" + netSideAreaLeft + "</td></tr>" if netSideAreaLeft != ""
	quantity_table += "<tr><td>netSideAreaRight</td><td>" + netSideAreaRight + "</td></tr>" if netSideAreaRight != ""
	quantity_table += "<tr><td>LeftFaceArea</td><td>" + left_face_area + "</td></tr>" if left_face_area != ""
	quantity_table += "<tr><td>RightFaceArea</td><td>" + right_face_area + "</td></tr>" if right_face_area != ""
	quantity_table += "<tr><td>HorizontalArea</td><td>" + horizontal_area + "</td></tr>" if horizontal_area != ""		
	quantity_table += "<tr><td>grossFootprintArea</td><td>" + grossFootprintArea + "</td></tr>" if grossFootprintArea != ""
	quantity_table += "<tr><td>netFootprintArea</td><td>" + netFootprintArea + "</td></tr>" if netFootprintArea != ""
	quantity_table += "<tr><td>perimeter</td><td>" + perimeter + "</td></tr>" if perimeter != ""
	quantity_table += "<tr><td>netWallArea</td><td>" + netWallArea + "</td></tr>" if netWallArea != ""
	quantity_table += "<tr><td>grossWallArea</td><td>" + grossWallArea + "</td></tr>" if grossWallArea != ""
	quantity_table += "<tr><td>netFloorArea</td><td>" + netFloorArea + "</td></tr>" if netFloorArea != ""
	quantity_table += "<tr><td>grossFloorArea</td><td>" + grossFloorArea + "</td></tr>" if grossFloorArea != ""
	quantity_table += "<tr><td>Volume_geometry</td><td>" + volume_geometry + "</td></tr>" if volume_geometry != ""
	quantity_table += "<tr><td>Area__geometry</td><td>" + area__geometry + "</td></tr>" if area__geometry != ""
	quantity_table += "<tr><td>AreaSide__geometry</td><td>" + area_side__geometry + "</td></tr>" if area_side__geometry != ""
	quantity_table += "<tr><td>Thickness</td><td>" + thickness + "</td></tr>" if thickness != ""
	quantity_table += "<tr><td>Default Thickness</td><td>" + default_Thickness + "</td></tr>" if default_Thickness != ""
	quantity_table += "</table>"
	res=res + "<tr><td>" + $ifcClassesNames[obj.class.to_s].sub("Ifc","")  + "</td><td>" + obj.name + "</td><td>" + obj.globalId + "</td>"			
	if obj.class.to_s.upcase.include?("TYPE") == false
		res=res + "<td>" 
		res += quantity_table if quantity_table != "<table></table>"
		res=res + "</td>"						
	end
	}
	return "" if not hasIfcBuildingElement	
	totalThickness=0
	if matObj.class.to_s.upcase == "IFCMATERIALLAYERSETUSAGE"	
		matObj.forLayerSet.toIfcObject
		ifcMaterialLayerSetObj= $ifcObjects[matObj.forLayerSet.delete("(").delete(")").delete("#").to_i]				
		layerSetName=ifcMaterialLayerSetObj.layerSetName
		res=res + "<td>" + layerSetName 	+ "</td><td><table>"			
		materialLayers=ifcMaterialLayerSetObj.materialLayers.to_s
		materialLayers.to_s.toIfcObject
		material=[]
		layerThickness=[]
		isVentilated=[]

		materialLayers.to_s.delete("(").delete(")").gsub(",","").split("#").each { |m_layer|				
		m_layerObj=$ifcObjects[m_layer.to_i]	
		next if m_layerObj == nil
		material << m_layerObj.material						
		layerThickness << m_layerObj.layerThickness.to_f
		isVentilated << m_layerObj.isVentilated
		totalThickness += m_layerObj.layerThickness.to_f		
		m_layerObj.material.toIfcObject
		res=res + "<tr><td>" + $ifcObjects[m_layerObj.material.delete("#").to_i].name.to_s + "(#" + $ifcObjects[m_layerObj.material.delete("#").to_i].line_id.to_s + ")</td>"
		res=res + "<td>" + m_layerObj.layerThickness.to_f.to_s + "</td></tr>"
		}	
	res=res + "</table></td>"
	layerSetDirection=matObj.layerSetDirection # AXIS1,AXIS2,AXIS3
	directionSense=matObj.directionSense #POSITIVE,NEGATIVE
	offsetFromReferenceLine=matObj.offsetFromReferenceLine					
	res=res + "<td>" + layerSetDirection.to_s + "</td><td>"  + directionSense.to_s + "</td><td>"  + offsetFromReferenceLine.to_s + "</td></tr></table>"
	elsif matObj.class.to_s.upcase == "IFCMATERIAL"
		res=res + "<td>" + matObj.name.to_s +  "(#" + matObj.line_id.to_s + ")</td></tr></table>"
	elsif matObj.class.to_s.upcase == "IFCMATERIALLIST"
		res=res + "<td>" 
		matObj.materials.toIfcObject
		matObj.materials.delete("(").delete(")").gsub(",","").split("#").each { |mat|				
		mObj=$ifcObjects[mat.to_i]
		next if mObj == nil
		res=res +  mObj.name.to_s + "(#" + matObj.line_id.to_s + ")<br />"					
		}						
		res=res + "</td></tr></table>"	
	elsif 	matObj.class.to_s.upcase == "IFCMATERIALLAYERSET"
		layerSetName=matObj.layerSetName
		res=res + "<td>" + layerSetName 	+ "</td><td><table>"			
		materialLayers=matObj.materialLayers.to_s
		materialLayers.toIfcObject
		material=[]
		layerThickness=[]
		isVentilated=[]
		materialLayers.delete("(").delete(")").gsub(",","").split("#").each { |m_layer|						
		m_layerObj=$ifcObjects[m_layer.to_i]			
		next if m_layerObj == nil
		material << m_layerObj.material						
		layerThickness << m_layerObj.layerThickness.to_f
		isVentilated << m_layerObj.isVentilated
		totalThickness += m_layerObj.layerThickness.to_f	
		m_layerObj.material.toIfcObject
		res=res + "<tr><td>" + $ifcObjects[m_layerObj.material.delete("#").to_i].name.to_s + "(" + m_layerObj.material.delete("#")+ ")</td>"
		res=res + "<td>" + m_layerObj.layerThickness.to_f.to_s + "</td></tr>"
		}	
		res=res + "</table></td>"				
		res=res + "</td></tr></table>"
	end	
	res += "<br><b>Sum of Volume:</b>:" + sum_volume.to_s if sum_volume > 0
	res += "<br><b>Sum of Area:</b>:" + sum_area.to_s if sum_area > 0
	res
end
#Methods aliases:
alias :quantityTakeOff :qto	
end
