class IFCSURFACESTYLE
attr_accessor :surfaceColour
	def initialize1(args)	
		args[2].delete("(").delete(")").gsub(",","").split("#").each { |o|	
		next if o == ""
		("#" + o).to_s.toIfcObject
		styleObj=$ifcObjects[o.to_i]
		#next if styleObj == nil	
		if styleObj.class.to_s.upcase == "IfcSurfaceStyleShading".upcase or styleObj.class.to_s.upcase == "IfcSurfaceStyleRendering".upcase			
			styleObj.surfaceColour.toIfcObject
			o=$ifcObjects[styleObj.surfaceColour.delete("#").to_i]
			if o != nil and o.respond_to?("to_RGB")
				@surfaceColour = o.to_RGB + "<div style=\"background-color:" + o.to_RGB_HEX + "\">&nbsp;</div>"				
			end
		end			
		} 
	end	
	
	def to_dae_material						
		$library_materials["<material id=\"mat_"  +  @line_id.to_s.delete("#") + "\" name=\"#@name\">"] = "<instance_effect url=\"#ID#@line_id\"/></material>\n"
		res="\n<profile_COMMON>\n<technique sid=\"COMMON\"><lambert><diffuse>"		
		@styles.toIfcObject.values.each { |styleObj|									
			if styleObj.class.to_s.upcase == "IfcSurfaceStyleShading".upcase
				styleObj.surfaceColour.toIfcObject
				surfaceColour_o=$ifcObjects[styleObj.surfaceColour.delete("#").to_i]
				surfaceColour_o != nil and surfaceColour_o.respond_to?("to_RGB") ? surfaceColour = "<color>" + o.to_RGB	 + " 1 </color>":surfaceColour=""
			elsif styleObj.class.to_s.upcase == "IfcSurfaceStyleRendering".upcase
				styleObj.surfaceColour.toIfcObject
				styleObj.diffuseColour.toIfcObject
				styleObj.transmissionColour.toIfcObject
				styleObj.reflectionColour.toIfcObject
				styleObj.diffuseTransmissionColour.toIfcObject
				styleObj.specularColour.toIfcObject				
				surfaceColour = "<color>" + $ifcObjects[styleObj.surfaceColour.delete("#").to_i].to_RGB	 + " 1 </color>"
				styleObj.transparency.to_f > 0 			? transparency= styleObj.transparency : transparency=""
				diffuseColour_o=$ifcObjects[styleObj.diffuseColour.delete("#").to_i]
				transmissionColour_o=$ifcObjects[styleObj.transmissionColour.delete("#").to_i]
				reflectionColour_o=$ifcObjects[styleObj.reflectionColour.delete("#").to_i]
				diffuseTransmissionColour_o=$ifcObjects[styleObj.diffuseTransmissionColour.delete("#").to_i]
				specularColour_o=$ifcObjects[styleObj.specularColour.delete("#").to_i]				
				diffuseColour_o != nil and diffuseColour_o.respond_to?("to_RGB") 			? diffuseColour= "<color>" + diffuseColour_o.to_RGB	 + " 1 </color>" : diffuseColour=""
				transmissionColour_o != nil and transmissionColour_o.respond_to?("to_RGB")	? transmissionColour="<color>" + transmissionColour_o.to_RGB	 + " 1 </color>" : transmissionColour=""
				diffuseTransmissionColour_o != nil and diffuseTransmissionColour_o.respond_to?("to_RGB") ? diffuseTransmissionColour="<color>" + diffuseTransmissionColour_o.to_RGB	 + " 1 </color>" :
				reflectionColour_o != nil and reflectionColour_o.respond_to?("to_RGB")		? reflectionColour="<color>" + reflectionColour_o.to_RGB	 + " 1 </color>" : reflectionColour=""
				specularColour_o != nil and specularColour_o.respond_to?("to_RGB")			? specularColour="<color>" + specularColour_o.to_RGB	 + " 1 </color>" : specularColour=""
				#pecularHighlight=""  
				#reflectanceMethod=""			
			end	
			res= res + surfaceColour + "</diffuse>\n"			
			res= res + "<emission>\n<color>0.000000 0.000000 0.000000 1</color>\n</emission>\n<ambient>\n<color>0.000000 0.000000 0.000000 1</color>\n</ambient>\n"			
			transparency != "" ? res= res + "<transparency><float>" + transparency + "</float></transparency>" : nil
			res = res + "\n</lambert>\n</technique>\n</profile_COMMON>\n</effect>"
			}
		$library_effects["<effect id=\"ID#@line_id\">"] = res			
	end
end