class IFCGEOMETRICCURVESET
	def to_dae(objectPlacement=nil,*args)	
		Dae.attribute_to_dae(@elements,objectPlacement)
	end
	
	def to_dae_geometry(mesh_id="")
		Dae.to_dae_geometry(@elements,mesh_id)
	end
	
	def to_dae_node(local=nil)
		Dae.to_dae_node(@elements,local,"")
	end
	
	def svg(scale=1,transformation="")
	  res =""
	  @elements.toIfcObject.each { |k,v|
	   res += v.svg(scale,transformation) if v.respond_to?('svg') 
	  }
	  res
	end
end