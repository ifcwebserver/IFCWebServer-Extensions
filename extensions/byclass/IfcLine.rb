class IFCLINE
attr_accessor :p1 , :p2
	def xyz_array(value=1)
		xyz=[]
		@pnt.toIfcObject
		@dir.toIfcObject
		obj_point=$ifcObjects[@pnt.delete("#").to_i]
		xyz << obj_point.x.to_s + " "
		xyz << obj_point.y.to_s + " "
		if obj_point.z != nil
			xyz << obj_point.z.to_s + " "
		else
			xyz << "z " 
		end
		obj_vector=$ifcObjects[@dir.delete("#").to_i]
		obj_orientation=$ifcObjects[obj_vector.orientation.delete("#").to_i]
		dir1=obj_orientation.dir1.to_f
		dir2=obj_orientation.dir2.to_f
		if obj_point.z != nil
		dir3 =obj_orientation.dir3.to_f
		else
		dir3=nil
		end		
		magnitude=obj_vector.magnitude.to_f		 
		xyz << (obj_point.x.to_f + magnitude*dir1*value).to_s + " "
		xyz << (obj_point.y.to_f + magnitude*dir2*value).to_s + " "
		if obj_point.z != nil
		xyz << (obj_point.z.to_f + magnitude*dir3*value).to_s + " "
		else
		xyz << "z "
		end
		#puts "<br>xzy for IfcLine:" + xyz.to_s + "Length "  + xyz.size.to_s
		return xyz
	end
		
	def xyz_min_max(value=1)
		@pnt.toIfcObject
		@dir.toIfcObject
		obj_point=$ifcObjects[@pnt.delete("#").to_i]
		x1= obj_point.x.to_f
		y1= obj_point.y.to_f
		if obj_point.z != nil
			z1 = obj_point.z.to_f
		end
		obj_vector=$ifcObjects[@dir.delete("#").to_i]
		obj_orientation=$ifcObjects[obj_vector.orientation.delete("#").to_i]
		dir1=obj_orientation.dir1.to_f
		dir2=obj_orientation.dir2.to_f
		if obj_point.z != nil
			dir3 =obj_orientation.dir3.to_f
		else
			dir3=nil
		end		
		magnitude=obj_vector.magnitude.to_f		 
		x2=(obj_point.x.to_f + magnitude*dir1*value).to_f
		y2= (obj_point.y.to_f + magnitude*dir2*value).to_f
		if obj_point.z != nil
			z2 =(obj_point.z.to_f + magnitude*dir3*value).to_f
		end
		return "<xmin>" + [x1,x2].min.to_s + "</xmin><xmax>" +  [x1,x2].max.to_s + "</xmax><ymin>" +  [y1,y2].min.to_s + "</ymin><ymax>" +  [y1,y2].max.to_s + "</ymax>"#<zmin>" +[z1,z2].min , [z1,z2].max
	end	
end