class IFCFACETEDBREP
	def to_dae(objectPlacement=nil,*args)	
		Dae.attribute_to_dae(@outer,objectPlacement)
	end
	
	def to_dae_geometry
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