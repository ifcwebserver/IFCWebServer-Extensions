class IFCPOLYLINE
attr_accessor :x_min, :x_max ,:y_min , :y_max
	def to_a
		res=""	
		@points.to_s.toIfcObject
		points_list = @points.to_s.gsub(",","").sub("(","").sub(")","").split("#")
		points_list.each { |pnt|		
		o=$ifcObjects[pnt.to_i]
			if o != nil
				res=res+ o.to_xyz	+ " "
			else
			puts "IFCCARTESIANPOINT is null" + points_list[i]
			end
		}		
		return res		
	end
	
	def xyz_array
		@points.to_s.toIfcObject		
		points_list = @points.to_s.gsub(",","").sub("(","").sub(")","").split("#")
		res=[]			
		points_list.each { |pnt|	
		next if pnt == ""
		o=$ifcObjects[pnt.to_i]
		res << o.x.to_s + " "
		res << o.y.to_s + " "
		if o.z == nil
			res << "z "
		else
			res << o.z.to_s + " "
		end					
		}			
		return  res	
	end
	
	def xy_array
		@points.to_s.toIfcObject		
		points_list = @points.to_s.gsub(",","").sub("(","").sub(")","").split("#")
		res=[]			
		points_list.each { |pnt|	
		next if pnt == ""
		o=$ifcObjects[pnt.to_i]
		res << o.x.to_s + " "
		res << o.y.to_s + " "				
		}			
		return  res	
	end

	def xy_min_max
		@points.to_s.toIfcObject
		points_list = @points.to_s.gsub(",","").sub("(","").sub(")","").split("#")
		x=[]	
		y=[]				
		points_list.each { |pnt|
		next if pnt == ""
		o=$ifcObjects[pnt.to_i]				
		x << o.x.to_f
		y << o.y.to_f		
		}
		@x_min=x.min
		@x_max=x.max
		@y_min=y.min
		@y_max=y.max
		return  "#@x_min,#@y_min,#@x_max,#@y_max"
	end
	
	def to_xml(obj=self)
	xml=""
	@points.to_s.toIfcObject.each { |k,o| xml= xml + "\n" + o.to_xml }
	"\n<IFCPOLYLINE LINEID='"  + @line_id.to_s + "'>" + xml  + "\n</IFCPOLYLINE>"
	end
	
	def to_svg
		SVG.to_svg(self)
	end
	
	def svg(scale=1,transformation="")
	    res=""
		@points.to_s.toIfcObject		
		style = " style=\"stroke:red;stroke-width:0.01;fill:gray;opacity:0.75\" "
	    style=$svg_style if $svg_style != nil		
		style1 =" style='stroke:red;stroke-width:0.01;fill:#ffffff;opacity:1' "
		counter=0
		@line_id.to_s.sub("#","").split('#').each { |p|		
		counter +=1
		("#"+p).toIfcObject
		obj=$ifcObjects[p.to_i]		
		pnt=obj.points.gsub("#","").sub("(","").sub(")","").split(',') 
		obj.points.to_s.toIfcObject			
		#puts pnt.to_s + "<br>"		
		x=[];y=[];z=[]
		(pnt.length).times do |i|
			p=$ifcObjects[pnt[i].to_i]
			x[i]=p.x.to_f
			y[i]=p.y.to_f
			z[i]=p.z.to_f
		end	
		x_min=x.min;x_max=x.max;y_min=y.min;y_max=y.max;z_min=z.min;z_max=z.max		
		if	transformation== ""
			transformation= " transform='translate(" + (-1.05*x_min*scale).to_s  + "," +  (-1.05*y_min*scale).to_s + ") scale(" + scale.to_s + ")'"
		end
		res += "<g " + transformation + " >"
		if pnt.length == 3
			res +=   "<path  d=\"m " + x[0].round_to(2).to_s + "," + y[0].round_to(2).to_s + "," 
			res +=  x[1].round_to(2).to_s + "," + y[1].round_to(2).to_s + "\" id=\"" + @line_id.to_s + "\"/>\n</g>"
		else	
			res += "<polyline points='"	
			(pnt.length).times do |i|
				next if x[i] == nil
				if z_min == z_max 
					res += x[i].round_to(2).to_s + "," + y[i].round_to(2).to_s + " "
				elsif y_min == y_max 
					res += x[i].round_to(2).to_s + "," + z[i].round_to(2).to_s + " "
				elsif x_min== x_max
					res += y[i].round_to(2).to_s + "," + z[i].round_to(2).to_s + " "		
				else				
				end
			end	
			if counter == 1
				res += "' " + style + " />\n</g>"
			else
				res += "' " + style1 + " />\n</g>"
			end
		end
		}	
		
		res
	end
	
	def area
		area=0
		@points.to_s.toIfcObject
		pnts=[]
		@points.to_s.gsub(",","").sub("(","").sub(")","").split("#").each { |p|		
		pnts << p if p != ""
		}
		j=0		
		pnts.size.times do |i|
			j = j +1
			j= 0 if j== pnts.size
			p=$points[pnts[j].to_i]
			p1=$points[pnts[i].to_i]
			area += (p1.x + p.x)*(p1.y - p.y) # if p1.z == nil or p1.z ==  p.z  
			#area += (p1.y + p.y)*(p1.z - p.z) if p1.z != nil and p1.x ==  p.x  
			#area += (p1.x + p.x)*(p1.z - p.z) if p1.z != nil and p1.y ==  p.y 			
		end		
		((area * 0.5).abs*$ifcUnit["Length"]*$ifcUnit["Length"])	
	end	
	
	def perimeter
		perimeter=0
		@points.to_s.toIfcObject	
		points_list = @points.gsub("#","").sub("(","").sub(")","").split(',') 
		(points_list.length-1).times do |i|
				p=$ifcObjects[points_list[i].to_i]		
				p1=$ifcObjects[points_list[i+1].to_i]						
				p.z != nil ? perimeter = perimeter + Math.sqrt((p.x - p1.x)**2 +(p.y - p1.y)**2 + (p.z - p1.z)**2) :  perimeter = perimeter + Math.sqrt((p.x - p1.x)**2 +(p.y - p1.y)**2)   
		end	
		perimeter.to_s		
	end
	
	def contains_point?(point)
	   @points.to_s.toIfcObject
	   points_list = @points.to_s.gsub(",","").sub("(","").sub(")","").split("#")
	  return false if outside_bounding_box?(point)
	  contains_point = false
	  i = -1
	  j =points_list.size - 1
	  while (i += 1) < self.size
		a_point_on_polygon =points_list[i]
		trailing_point_on_polygon = points_list[j]
		if point_is_between_the_ys_of_the_line_segment?(point, a_point_on_polygon, trailing_point_on_polygon)
		  if ray_crosses_through_line_segment?(point, a_point_on_polygon, trailing_point_on_polygon)
			contains_point = !contains_point
		  end
		end
		j = i
	  end
	  return contains_point
	end
	
	def outside_bounding_box?(point)
	  bb_point_1, bb_point_2 = bounding_box
	  max_x = [bb_point_1.x, bb_point_2.x].max
	  max_y = [bb_point_1.y, bb_point_2.y].max
	  min_x = [bb_point_1.x, bb_point_2.x].min
	  min_y = [bb_point_1.y, bb_point_2.y].min	  
	  point.x < min_x || point.x > max_x || point.y < min_y || point.y > max_y
	end
	
	def to_dae(placement=nil, *args)
		@points.to_s.toIfcObject
		if $dae_single_file == true
			$dae_geometry_file.puts to_dae_geometry
			$dae_node_file.puts to_dae_node(placement)
		else
			$dae_file = File.open('dae/' + $username + "/" + $ifc_file_name + "_IFCPOLYLINE_" + @line_id.to_s + '.dae', 'w')
			$dae_file.puts "<?xml version='1.0' encoding='UTF-8' standalone='no' ?><COLLADA xmlns='http://www.collada.org/2005/11/COLLADASchema' version='1.4.1'><asset><contributor>"
			$dae_file.puts "	<authoring_tool>IFC Web  Server v.1</authoring_tool></contributor><created>" + Time.now.strftime("%Y-%m-%dT%H:%M:%S") + "</created><modified>" + Time.now.strftime("%Y-%m-%dT%H:%M:%S")  + "</modified><unit meter='1.0' name='meters' /><up_axis>Z_UP</up_axis>"
			$dae_file.puts "	</asset><library_visual_scenes>"
			$dae_file.puts "	<visual_scene id='ifcwebserver'>"
			$dae_file.puts to_dae_node(placement)
			$dae_file.puts "</visual_scene></library_visual_scenes><library_geometries>"
			$dae_file.puts to_dae_geometry
			$dae_file.puts "</library_geometries>"
			$dae_file.puts Dae.material_section
			$dae_file.puts "<scene><instance_visual_scene url='#ifcwebserver' /></scene></COLLADA>"
			$dae_file.close		
		end	
	end
	
	def to_dae_geometry(mesh_id="")
		@points.to_s.toIfcObject
		points_list = @points.to_s.gsub(",","").sub("(","").sub(")","").split("#")
		dae=""
		if mesh_id == ""
			dae = dae + "<geometry id='" +  "IFCPOLYLINE_mesh_" + @line_id.to_s + "'>"
		else
			dae = dae + "<geometry id='" +  mesh_id + "'>"
		end
		dae = dae + "<mesh><source id='s_" + @line_id.to_s + "'><float_array id='pos_arr" + @line_id.to_s + "' count='" + (points_list.length*3).to_s + "'>"
		xyz=""
		points_list.length.times do |i| 
		("#"+points_list[i]).toIfcObject
		#o = $ifcObjects[points_list[i].to_i]
		o =$points[points_list[i].to_i]
		if o != nil
			xyz= xyz + o.x.to_s + " " + o.y.to_s + " " + o.z.to_s + " " if o.z != nil
			xyz= xyz + o.x.to_s + " " + o.y.to_s + " 0.0 " if o.z == nil 					
		end				
		end				
		dae = dae + xyz				
		dae = dae + "</float_array><technique_common><accessor count='" + points_list.length.to_s + "' source='#pos_arr" + @line_id.to_s + "' stride='3'><param name='X' type='float'/><param name='Y' type='float' /><param name='Z' type='float' /></accessor></technique_common>"
		dae = dae + "</source>"
		dae = dae + "<vertices id='vertices_" + @line_id.to_s + "'>"
		dae = dae + "    <input semantic='POSITION' source='#s_" + @line_id.to_s + "'/>"
		dae = dae + "</vertices>"
		if @colsed == false
			not_closed = -1
		else
			not_closed=0
		end
		dae = dae + "<linestrips count='" + (points_list.length+not_closed).to_s + "' material='Material'>"
		dae = dae + "    <input offset='0' semantic='VERTEX' source='#vertices_" + @line_id.to_s + "' />"
		#dae = dae + "<vcount>" + (points_list.length+not_closed).to_s + "</vcount>"
		dae = dae + " <p>"
		(points_list.length).times do |i|
			dae = dae + i.to_s + " "
		end		
		if @colsed == true
			#dae = dae + (polygon.length-1).to_s + " 0"
		end
		dae = dae + "</p></linestrips></mesh></geometry>"	
		return dae				
	end
	
	def to_dae_node(placement=nil)
		@points.to_s.toIfcObject
		if placement != nil
			obj_localplacement = $ifcObjects[placement.delete("#").to_i]
		end	
		dae_node=""
		dae_node=dae_node + "<node name='" +  "IFCPOLYLINE_" + @line_id.to_s + "'>"
		if obj_localplacement != nil and obj_localplacement.respond_to?('xyz')
			obj_localplacement.xyz
			res= res + "<translate>" +  obj_localplacement.x.to_s + " " +  obj_localplacement.y.to_s + " "+  obj_localplacement.z.to_s + "</translate>"
		end
		dae_node=dae_node + "<instance_geometry url='#IFCPOLYLINE_mesh_" + @line_id.to_s + "'>"
		dae_node=dae_node + "<bind_material>"
		dae_node=dae_node + "<technique_common>"
		dae_node=dae_node + "<instance_material symbol='Material' target='#" + $dae_mat + "'>"
		#dae_node=dae_node + "<bind_vertex_input semantic='UVSET0' input_semantic='TEXCOORD' input_set='0' />"
		dae_node=dae_node + "</instance_material>"
		dae_node=dae_node + "</technique_common>"
		dae_node=dae_node + "</bind_material>"
		dae_node=dae_node + "</instance_geometry>"
		dae_node=dae_node + "</node>"				
		return dae_node
	end
	
	def self.new_from_points_array(xy_array=[])	
	  @points=""
	  xy_array.each { |point|
	    point_id =  new_id
	    @points += "#" + point_id.to_s + ","
	    IFCCARTESIANPOINT.new(point_id,["(" + point[0].to_s  + "," + point[1].to_s + ")"])
	  }	
	  self.new(new_id,["(" + @points[0..-2] +")"])
	end
	
	private
	def point_is_between_the_ys_of_the_line_segment?(point, a_point_on_polygon, trailing_point_on_polygon)
	  (a_point_on_polygon.y <= point.y && point.y < trailing_point_on_polygon.y) || 
	  (trailing_point_on_polygon.y <= point.y && point.y < a_point_on_polygon.y)
	end
	
	def ray_crosses_through_line_segment?(point, a_point_on_polygon, trailing_point_on_polygon)
	  (point.x < (trailing_point_on_polygon.x - a_point_on_polygon.x) * (point.y - a_point_on_polygon.y) / 
				 (trailing_point_on_polygon.y - a_point_on_polygon.y) + a_point_on_polygon.x)
	end
end