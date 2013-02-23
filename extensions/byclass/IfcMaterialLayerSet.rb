class IFCMATERIALLAYERSET
  def materials_list
   res = []
   @materialLayers.toIfcObject.each { |k,v|
   res << v.material.to_obj.name.gsub("'","")
   }
   res
  end
  
  def materials_thickness_list
   res = []
   @materialLayers.toIfcObject.each { |k,v|
   res << v.material.to_obj.name.gsub("'","") + "@" + v.layerThickness.to_s + "|"
   }
   res
  end
end