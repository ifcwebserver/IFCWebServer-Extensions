class IFCSHAPEREPRESENTATION
	def to_dae_geometry(mesh_id="")
		Dae.to_dae_geometry(@items,mesh_id)		
	end	
	
	def to_dae_node(local=nil)		
	    res = ""
		@items.to_s.toIfcObject.each { |k,v|
		res += Dae.to_dae_node(v,local,"",v.class.to_s + "_" + v.line_id.to_s)
		}
		res
	end	
	
	def to_dae(objectPlacement=nil,*args)
		Dae.attribute_to_dae(@items,objectPlacement,self.class.to_s,@line_id.to_s)
	end
	
	def volume
	volume= 0
	@items.to_s.toIfcObject.each { |k,v|
	volume += v.volume.to_f if v.respond_to?('volume')  
	}
	volume	
	end
end