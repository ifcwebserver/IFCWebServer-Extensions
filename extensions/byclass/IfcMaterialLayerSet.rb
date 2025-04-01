class IFCMATERIALLAYERSET
  def materials_list
   res = []
   @materialLayers.toIfcObject.each { |k,v|
   res << encode_string(v.material.to_obj.name.gsub("'",""))
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

  def materials_layers_html
   #doc:<div class='documentaion' > This method shows the details of material layers (material name , layer thickness) in a table</div>
   totalThickness = 0
   res = "<table><tr><th>Material</th><th>LayerThickness</th></tr>"
   @materialLayers.toIfcObject.each { |k,v|
   res += "<tr><td>" +  v.material.to_obj.name.gsub("'","") + "</td><td>" + v.layerThickness.to_s + "</td></tr>"
   totalThickness += v.layerThickness.to_f
   }
   res += "<tr><th>TotalThickness</th><td><b>" + totalThickness.to_s + "</b><td></tr>"
   res += "</table>"
   res
  end

end