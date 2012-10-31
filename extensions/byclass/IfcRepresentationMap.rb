class IFCREPRESENTATIONMAP
	def to_dae		
		 Dae.attribute_to_dae(@mappedRepresentation,@mappingOrigin)
	end
	 
	def to_dae_geometry(local=nil)
		Dae.to_dae_geometry(@mappedRepresentation)
	end

	def to_dae_node(local=nil)
		Dae.to_dae_node(@mappedRepresentation,local,"")
	end
end