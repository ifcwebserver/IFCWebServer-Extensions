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
		@styles.toIfcObject.values.each { |styleObj|									
			if styleObj.class.to_s.upcase == "IfcSurfaceStyleRendering".upcase
				$library_materials[@line_id]=styleObj.material.sub("MATNAME",@name.gsub("'","")).sub("MATID","Mat-" + @line_id.to_s)
				$library_effects[styleObj.line_id] = styleObj.effect
			end				
		}			
	end
end