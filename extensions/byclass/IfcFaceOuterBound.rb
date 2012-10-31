class IFCFACEOUTERBOUND
	def to_dae(objectPlacement=nil)
		Dae.to_dae(self,objectPlacement)
	end
	
	def to_dae_geometry
		Dae.to_dae_geometry(@bound)		
	end
	
	def to_dae_node(local=nil)
		Dae.to_dae_node(@bound,local,"")
	end

	def to_mesh
		@bound.toIfcObject
		obj= $ifcObjects[@bound.delete("#").to_i]
		if obj.respond_to?('to_mesh')
			return obj.to_mesh
		else
		 puts 	"class: IFCFACEOUTERBOUND.to_mesh is not yet supported for "	+ obj.class.to_s
		end				
	end
	
	def area		
		@bound.toIfcObject
		ifcloopObj=$ifcObjects[@bound.delete("#").to_i]						 	
		if ifcloopObj.respond_to?('area')
			ifcloopObj.area.to_f
		else
			$log["<br>Line:" + __LINE__.to_s ]= " line_id :" +  ifcloopObj.class.to_s + ".area() is not yet supported"
		end	
	end	
end