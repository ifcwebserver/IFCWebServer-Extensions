class IFCFACETEDBREP
	def to_dae(objectPlacement=nil,*args)	
		Dae.attribute_to_dae(@outer,objectPlacement)
	end
	
	def to_mesh	
		res=""	
		@outer.to_s.toIfcObject		
		@outer.to_s.gsub(",","").sub("(","").sub(")","").split("#").each { |outer|
		next if outer == ""		
		obj= $ifcObjects[outer.to_i]		
		if obj.respond_to?('to_mesh')
		res=res + obj.to_mesh
		end
		}
		return res	
	end
	
	def to_dae_geometry(mesh_id="")
		Dae.to_dae_geometry(@outer)
	end
	
	def to_dae_node(local=nil)
		Dae.to_dae_node(@outer,local,"")
	end
	
	def area
		@outer.toIfcObject
		o=$ifcObjects[@outer.delete("#").to_i]
		return o.area if o != nil and o.respond_to?("area")		
	end
	
end