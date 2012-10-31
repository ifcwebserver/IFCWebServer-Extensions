class IFCCLOSEDSHELL
	def area
		sum=0
		@cfsFaces.toIfcObject
		@cfsFaces.gsub(",","").sub("(","").sub(")","").split("#").each { |face|
		next if face == ""		
		obj= $ifcObjects[face.to_i]		
			if obj.respond_to?('area')
				sum += obj.area
			else
				$log["<br>Line:" + __LINE__.to_s ]= "  " +  obj.class.to_s + ".area() is not yet supported"
			end
		}
		return sum
	end
	
	def to_dae(placement=nil, *args)
		Dae.to_dae(self,placement,args)		
	end	
	
	def to_dae_geometry(mesh_id="")
		Dae.to_dae_geometry(@cfsFaces.to_s,mesh_id)
	end

	def to_dae_node(placement=nil)
		Dae.to_dae_node(self,placement,@cfsFaces.to_s)
	end
end