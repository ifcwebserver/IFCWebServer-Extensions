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
 

  def x_axis
   if @refDirection.to_obj == nil and @axis.to_obj == nil
     [1.0,0.0,0.0]     
   else
	 @refDirection.to_obj.get_normal
	end
  end	
  
  def z_axis
    if @refDirection.to_obj == nil and @axis.to_obj == nil
	  [0.0,0.0,1.0]
	else	  
	  @axis.to_obj.get_normal
	end
  end
  
  def xyz
    return @x,@y,@z
  end
  
  def matrix
    if @refDirection.to_obj == nil and @axis.to_obj == nil
	  [1,0,0,0,0,1,0,0,0,0,1,0,@x,@y,@z,1]
	else
      #Cross Product of Two Vectors	
	  #u = < a , b , c > and v = < d , e , f >
      #w(x,y,z) = u x v = < a , b , c > x < d , e , f > = < x , y , z > 
      #x = b*f - c*e , y = c*d - a*f and z = a*e - b*d
      x=x_axis	
	  z=z_axis
	  y=[]
	  y[0]=x[1]*z[2]-x[2]*z[1]
	  y[1]=x[2]*z[0]-x[0]*z[2]
	  y[2]=x[0]*z[1]-x[1]*z[0]	  
	  [x[0],x[1],x[2],0,  y[0],y[1],y[2],0,	  z[0],z[1],z[2],0,	  @x,@y,@z,1 ]
	end
  end
  
  def matrix2d
    if @refDirection.to_obj == nil and @axis.to_obj == nil
	  [1,0,0,1,@x,@y]
	else
      #Cross Product of Two Vectors	
	  #u = < a , b , c > and v = < d , e , f >
      #w(x,y,z) = u x v = < a , b , c > x < d , e , f > = < x , y , z > 
      #x = b*f - c*e , y = c*d - a*f and z = a*e - b*d
      x=x_axis	
	  z=z_axis
	  y=[]
	  y[0]=x[1]*z[2]-x[2]*z[1]
	  y[1]=x[2]*z[0]-x[0]*z[2]
	  y[2]=x[0]*z[1]-x[1]*z[0]	  
	  [x[0],x[1],y[0],y[1],@x,@y]
	end
  end
end