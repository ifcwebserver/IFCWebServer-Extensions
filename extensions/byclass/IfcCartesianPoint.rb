class IFCCARTESIANPOINT
attr_accessor :x,:y,:z , :dim
	def initialize1(args)		
		xyz=@coordinates.delete("(").delete(")").split(",")		
		@x= xyz[0].to_f.round_to(3)
		@y= xyz[1].to_f.round_to(3)
		xyz[2]? @z= xyz[2].to_f.round_to(3) :@z=nil
		@dim=3
		@dim=2 if @z==nil
		$points[@line_id.to_i]= Point.new(self.line_id,@x,@y,@z)
	end

	def to_xml( o=self)
		#"<IFCCARTESIANPOINT LINEID='"  + o.line_id.to_s + "'>\n <x>" + o.x.to_s + "</x><y>" + o.y.to_s + "</y> <z>" + o.z.to_s + "</z>\n</IFCCARTESIANPOINT>"
		#"<p id="  + o.line_id.to_s + ">\n <x>" + o.x.to_s + "</x><y>" + o.y.to_s + "</y> <z>" + o.z.to_s + "</z>\n</p>"
		"<IFCCARTESIANPOINT>\n<ID>"  + o.line_id.to_s + "</ID>\n\t<x>" + o.x.to_s + "</x>\n\t<y>" + o.y.to_s + "</y>\n\t<z>" + o.z.to_s + "</z>\n</IFCCARTESIANPOINT>"		
	end
	
	def to_xyz		
		if @z != nil then
			 @x.to_s + " , " + @y.to_s + " , " + @z.to_s
		else
			 @x.to_s + " , " + @y.to_s
		end
	end
	
	def xyz		
		xyz=@coordinates.delete("(").delete(")").split(",")		
		@x= xyz[0].to_f.round_to(3)
		@y= xyz[1].to_f.round_to(3)
		xyz[2]? @z= xyz[2].to_f.round_to(3) :@z=nil
	end
	
	def min_max
	#doc:<div class='documentaion' >return a list of Xmin,Xmax,Ymin,Ymax,Zmin,Zmax of all IfcCartesianPoint instances</div>
		x_min=0
		x_max=0
		y_min=0
		y_max=0
		z_min=0
		z_max=0
		ObjectSpace.each_object(IFCCARTESIANPOINT) { |o|
		x_min = o.x if o.x < x_min
		x_max = o.x if o.x > x_max	
		y_min = o.y if o.y < y_min
		y_max = o.y if o.y > y_max	
		z_min = o.z if o.z != nil and o.z < z_min
		z_max = o.z if o.z != nil and  o.z > z_max	
		}
		#puts "<Xmin>" + x_min.to_s + "</Xmin><Xmax>" + x_max.to_s + "</Xmax>"
		#puts "<Ymin>" + y_min.to_s + "</Ymin><Ymax>" + y_max.to_s + "</Ymax>"
		#puts "<Zmin>" + z_min.to_s + "</Zmin><Zmax>" + z_max.to_s + "</Zmax>"	
		x_min.to_s + "," + x_max.to_s + "," + y_min.to_s + "," + y_max.to_s + "," + z_min.to_s + "," + z_max.to_s 
	end	
end