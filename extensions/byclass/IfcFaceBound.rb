class IFCFACEBOUND	
	def get_normal
		res=""	
		@bound.toIfcObject		
		obj= $ifcObjects[@bound.delete("#").to_i]
			if obj.respond_to?('get_normal')
				res=res + obj.get_normal
			end		
		return res		
	end
	
	def to_mesh
		res=""	
		@bound.toIfcObject
		obj= $ifcObjects[@bound.delete("#").to_i]
		if obj.respond_to?('to_mesh')
			res=res + obj.to_mesh
		end		
		return res	
	end
	
	def to_dae(objectPlacement=nil,*args)	
		Dae.attribute_to_dae(@bound,objectPlacement)
	end
	
	
	def to_dae_geometry(mesh_id="")
		Dae.to_dae_geometry(@bound)
	end
	
	def to_dae_node(localplacement=nil)
		Dae.to_dae_node(@bound.to_s,localplacement,"")		
	end
	
	def area
		@bound.toIfcObject
		o=$ifcObjects[@bound.delete("#").to_i]
		if o.respond_to?("area")		
			o.area
		else
			$log["<br>Line:" + __LINE__.to_s ]= "  " +  o.class.to_s + ".area() is not yet supported"
		end
	end
end