class IFCAXIS2PLACEMENT3D
attr_accessor  :x , :y , :z	
	def initialize1(args)				
		return if @axis	 == nil
		@axis.toIfcObject if @axis != "$"
		@refDirection.toIfcObject if @axis != "$"
		@location.toIfcObject
		
		axisObj=$ifcObjects[@axis.delete("#").to_i] 
		dirObj=$ifcObjects[@refDirection.delete("#").to_i]		
		locationObj=$ifcObjects[@location.delete("#").to_i]
		
		@x=locationObj.x
		@y=locationObj.y
		@z=locationObj.z
		
		if @refDirection.strip == "$" or dirObj == nil
			dir1=1
			dir2=0
			dir3=0
		else
			dir1=dirObj.dir1.to_f
			dir2=dirObj.dir2.to_f
			dir3=dirObj.dir3.to_f
		end
		
		if @axis.strip == "$" or axisObj == nil
			axis_x=1
			axis_y=0
			axis_z=0
		else
			axisObj=$ifcObjects[@axis.delete("#").to_i]
			axis_x=axisObj.dir1.to_f
			axis_y=axisObj.dir2.to_f
			axis_z=axisObj.dir3.to_f
		end			
		if locationObj != nil
			if @axis.strip == "$" and @refDirection.strip == "$"  
				@x=locationObj.x
				@y=locationObj.y
				@z=locationObj.z
			elsif axis_x == 0 and axis_y == 1 and  axis_z == 0 and dir1 == 1
				@y=locationObj.x
				@x=locationObj.y
				@z=locationObj.z
			else	
				@x=locationObj.x 
				@y=locationObj.y 
				@z=locationObj.z 
			end				
		end	
	end
		
	def xyz
		return @x,@y,@z
	end
end