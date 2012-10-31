class IFCPRODUCTDEFINITIONSHAPE
	def to_dae(objectPlacement=nil,*args)
		#Dae.attribute_to_dae(@representations,objectPlacement)
		Dae.to_dae(self,objectPlacement)		
	end
	
	def to_dae_geometry(mesh_id="")
		Dae.to_dae_geometry(@representations,mesh_id)		
	end	
	
	def to_dae_node(local=nil)
		@representations.to_s.toIfcObject.each { |k,v|
		Dae.to_dae_node(v,local,"",v.class.to_s + "_" + v.line_id.to_s)
		}
	end	
end