class IFCFACE
	def to_mesh	
		res=""	
		@bounds.to_s.toIfcObject		
		@bounds.to_s.gsub(",","").sub("(","").sub(")","").split("#").each { |bound|
		next if bound == ""		
		obj= $ifcObjects[bound.to_i]
			if obj.respond_to?('to_mesh')
				res=res + obj.to_mesh
			end
		}
		return res	
	end
	
	def get_normal
		res=""
		@bounds.to_s.toIfcObject
		@bounds.to_s.gsub(",","").sub("(","").sub(")","").split("#").each { |bound|
		next if bound == ""	
		obj= $ifcObjects[bound.to_i]
			if obj.respond_to?('get_normal')
				res=res + obj.get_normal
			end
		}
		return res		
	end

	
	def to_dae(objectPlacement=nil,*args)
		Dae.attribute_to_dae(@bounds,objectPlacement)		
	end	
	
	def to_dae_geometry
		Dae.to_dae_geometry(@bounds)		
	end
	
	def to_dae_node(ifclocalplacemenet=nil)
		Dae.to_dae_node(self,ifclocalplacemenet,@bounds.to_s)
		#@bounds.to_s.toIfcObject
		#res="<node ID=\"" + @line_id.to_s + "\">"
		#@bounds.to_s.gsub(",","").sub("(","").sub(")","").split("#").each { |bound|
		#next if bound == ""
		#obj= $ifcObjects[bound.to_i]
		#	if obj.respond_to?('to_dae_node')
		#		res=res + obj.to_dae_node(ifclocalplacemenet)
		#	end
		#}
		#res=res + "</node>"
		#return res
	end
	
	def area
		sum=0	
		@bounds.to_s.toIfcObject
		@bounds.to_s.gsub(",","").sub("(","").sub(")","").split("#").each { |f|
		next if f == ""				
			faceObj=$ifcObjects[f.to_i]						 	
			if faceObj.respond_to?('area')
				sum += faceObj.area.to_f
			else
				$log["<br>Line:" + __LINE__.to_s ]= " line_id :" + f.to_s + faceObj.class.to_s + ".area() is not yet supported"
			end
			}			
		return sum
	end
end