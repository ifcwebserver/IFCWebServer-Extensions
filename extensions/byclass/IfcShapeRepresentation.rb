class IFCSHAPEREPRESENTATION
	def to_dae_geometry(mesh_id="")
		Dae.to_dae_geometry(@items,mesh_id)		
	end	
	
	def to_dae_node(local=nil)		
		@items.to_s.toIfcObject.each { |k,v|
		Dae.to_dae_node(v,local,"",v.class.to_s + "_" + v.line_id.to_s)
		}
	end	
	
	def to_dae(objectPlacement=nil,*args)	
		Dae.attribute_to_dae(@items,objectPlacement)
	end
end