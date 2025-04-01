class IFCMATERIALLAYERSETUSAGE
	def attach_to_obj(obj)
		#doc: <div class='documentaion' >This method links the names, count and total thickness of the material layers (IfcMaterialLayerSetUsage) which are associated to objects through the relation IfcRelAssociatesMaterial as a new attributes .</br> The new attributes to be used in reports or filters called:<ul> <li><i>ext_MaterialLayerSetUsage_material_name</i></li><li><i>ext_MaterialLayerSetUsage_layer_count</i></li><li><i>ext_MaterialLayerSetUsage_total_thickness</i></li><li><i>ext_MaterialLayerSetUsage_layerSetName</i></li><li><i>ext_MaterialLayerSetUsage_OffsetFromReferenceLine</i></li></ul></div>
		res = "</br>"
		layer_count = 0
		totalThickness = 0		
		forLayerSetObj=@forLayerSet.to_s.to_obj		
		forLayerSetObj.materialLayers.to_s.toIfcObject.each { |k,v|		
		totalThickness += v.layerThickness.to_f
		res +=  "|" + v.material.to_s.to_obj.name + "|" + v.layerThickness + "|</br>" if v.material.to_s.to_obj != nil
		layer_count += 1	
		}		
		layerSetName = forLayerSetObj.layerSetName				
		obj.instance_variable_set("@ext_MaterialLayerSetUsage_Material_name", encode_string(res))		
		obj.instance_variable_set("@ext_MaterialLayerSetUsage_Layer_count", layer_count)	
		obj.instance_variable_set("@ext_MaterialLayerSetUsage_Total_thickness", totalThickness)	
		obj.instance_variable_set("@ext_MaterialLayerSetUsage_LayerSetName", encode_string(layerSetName))
		obj.instance_variable_set("@ext_MaterialLayerSetUsage_OffsetFromReferenceLine", @offsetFromReferenceLine.to_f)		
	end
end
#ext_MaterialLayerSetUsage_material_name = IfcRelAssociatesMaterial.IfcMaterialLayerSetUsage.ForLayerSet. SUM OF (MaterialLayers[1...n].Material) AS STRING
#ext_MaterialLayerSetUsage_total_thickness = IfcRelAssociatesMaterial.IfcMaterialLayerSetUsage.ForLayerSet. SUM OF (MaterialLayers[1...n].LayerThickness)
#ext_MaterialLayerSetUsage_layer_count = IfcRelAssociatesMaterial.IfcMaterialLayerSetUsage.ForLayerSet. COUNT OF (MaterialLayers[1...n])
#ext_MaterialLayerSetUsage_layerSetName = IfcRelAssociatesMaterial.IfcMaterialLayerSetUsage.ForLayerSet.LayerSetName
 