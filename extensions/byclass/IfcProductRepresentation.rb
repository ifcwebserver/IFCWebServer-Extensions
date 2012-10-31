class IFCPRODUCTREPRESENTATION
	def to_dae(objectPlacement=nil,*args)
		Dae.attribute_to_dae(@representations,objectPlacement)		
	end	
end