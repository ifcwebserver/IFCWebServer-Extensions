class IFCLOCALPLACEMENT
attr_accessor :x , :y , :z 
	def location			
		current_placementRelTo=@placementRelTo		
		current_relativePlacement=@relativePlacement
		tmp_x=0
		tmp_y=0
		tmp_z=0
		if @x== nil 
		while current_placementRelTo.strip != "$" and current_relativePlacement != nil
				current_relativePlacement.toIfcObject
				obj1=$ifcObjects[current_relativePlacement.delete("#").to_i]
				#refDirectionObj=$ifcObjects[obj1.refDirection.delete("#").to_i]
				if obj1 == nil
					###	puts current_relativePlacement + "________"
				end
				#if refDirectionObj != nil then
				#dx=obj1.x.to_f  * refDirectionObj.dir1 
				#dy=obj1.y.to_f	* refDirectionObj.dir2 			
				#dz=obj1.z.to_f	* refDirectionObj.dir3
				#else
				dx=obj1.x.to_f  
				dy=obj1.y.to_f				
				dz=obj1.z.to_f	
				#end				
				tmp_x+=dx.to_f				
				tmp_y+=dy.to_f
				tmp_z+=dz.to_f			
			###end	
			#puts tmp_x ,tmp_y,tmp_z ,"<br>"
			current_placementRelTo.toIfcObject
			obj = $ifcObjects[current_placementRelTo.delete("#").to_i]		
			current_placementRelTo		=obj.placementRelTo	
			current_relativePlacement	=obj.relativePlacement	#
		end
		@x=tmp_x
		@y=tmp_y
		@z=tmp_z		
		return  "(#@x,\t#@y,\t#@z)"
		else
			return  "(#@x,\t#@y,\t#@z)"
		end		
	end
end