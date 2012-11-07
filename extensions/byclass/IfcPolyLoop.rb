class IFCPOLYLOOP
	def get_normal_default
		return "0 0 1"
	end
	
	def get_normal
		#p1 = $ifcObjects[polygon_list[1].to_i]
		#p2= $ifcObjects[polygon_list[0].to_i]
		#p3= $ifcObjects[polygon_list[2].to_i]	
		polygon_list = @polygon.to_s.gsub(",","").sub("(","").sub(")","").split("#")
		("#"+polygon_list[1].to_s).toIfcObject
		("#"+polygon_list[2].to_s).toIfcObject
		("#"+polygon_list[3].to_s).toIfcObject		
		p1 = $ifcObjects[polygon_list[2].to_i]
		p2= $ifcObjects[polygon_list[1].to_i]
		p3= $ifcObjects[polygon_list[3].to_i]		
		u_x = p2.x- p1.x
		u_y = p2.y- p1.y
		u_z	= p2.z- p1.z	
		v_x =p3.x- p1.x
		v_y =p3.y- p1.y
		v_z =p3.z- p1.z	
		nor_x = ( u_y * v_z) - ( u_z * v_y)
		nor_y = ( u_z * v_x) - ( u_x * v_z)
		nor_z = ( u_x * v_y) - ( u_y * v_x)
		nor_length= Math.sqrt(nor_x*nor_x+nor_y*nor_y+nor_z*nor_z)
		if nor_length != 0 then
			return (nor_x/nor_length).round_to(3).to_s + " " + (nor_y/nor_length).round_to(3).to_s + " " + (nor_z/nor_length).round_to(3).to_s 
		else
			return "0 0 1"
		end
	end
	
	
	def to_xml(obj=self)
		xml=""
		@polygon.to_s.toIfcObject.each { |k,o| xml= xml + "\n" + o.to_xml }
		"\n<IFCPOLYLOOP LINEID='"  + @line_id.to_s + "'>" + xml  + "\n</IFCPOLYLOOP>"
	end
	
	def to_svg
		@polygon.to_s.toIfcObject
		$svgFile= File.new("svg/" +  $username + "/" + @line_id.to_s + ".svg",  "w")
		res= ""
		res=res + "<?xml version='1.0' encoding='UTF-8'?>\n<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Strict//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd'>\n"
		res=res + "<html xmlns='http://www.w3.org/1999/xhtml'  xmlns:svg='http://www.w3.org/2000/svg'   xmlns:xlink='http://www.w3.org/1999/xlink'>\n"
		res=res + "<head>\n<title></title>\n</head>\n<body>\n"
		x=[]
		y=[]
		z=[]	
		@polygon.to_s.gsub(",","").sub("(","").sub(")","").split("#").each { |i|
		next if i == ""
			p=$ifcObjects[i.to_i]
			x << p.x.to_f
			y << p.y.to_f
			z << p.z.to_f		 
		}	
		x_min=x.min
		x_max=x.max
		y_min=y.min
		y_max=y.max
		z_min=z.min
		z_max=z.max
		dx=dy=dz=0
		dx=-1*x_min if x_min < 0
		dy=-1*y_min if y_min < 0
		dz=-1*z_min if z_min < 0
		res_svg=""
		res_svg=res_svg + "<svg version='1.1' xmlns='http://www.w3.org/2000/svg' width='100%' height='100%' preserveAspectRatio='xMinYMin meet' >\n"
		#res_svg += "<g transform=\" scale(1) translate(" + (-x_min).to_s + " " + (-y_min).to_s + ") \">"
		res_svg=res_svg + "<polygon points='"
		x.size.times { |i|
			if z_min == z_max 
				res_svg = res_svg + (x[i]+dx).to_s + "," + (y[i]+dy).to_s + " "
			elsif y_min == y_max 
				res_svg = res_svg + (x[i]+dx).to_s + "," + (z[i]+dz).to_s + " "
			elsif x_min== x_max
				res_svg = res_svg + (y[i]+dy).to_s + "," + (z[i]+dz).to_s + " "		
			else
			res=res + "<p>3D Polyloop</p></body>\n</html>" 
			$svgFile.puts res
			return ""
			end
		}	
		res_svg= res_svg + "' style='stroke:red;stroke-width:0.01;fill:lightgray' />"
		#res_svg +="</g>"
		res_svg += "\n</svg>"

		res=res + res_svg 
		res=res +"\n</body>\n</html>"
		$svgFile.puts res_svg
		return @line_id.to_s + ".svg"
	end	
		
	def to_xy_xml
		@polygon.to_s.toIfcObject
		x=[]
		y=[]
		res = ""	
		@polygon.to_s.gsub(",","").sub("(","").sub(")","").split("#").each { |i|
		next if i == ""	
			p=$points[i.to_i]
			res  =res +  "<point><x>" + p.x.to_s + "</x>"
			res  =res +  "<y>" + p.x.to_s + "</y></point>"
			return res
		}	
	end
	
	def perimeter1
		@polygon.to_s.toIfcObject
		perimeter=0	
		polygon_list = @polygon.to_s.gsub(",","").sub("(","").sub(")","").split("#")		
		(polygon_list.length-1).times do |i|	
			p=$points[polygon_list[i].to_i]
			p1=$points[polygon_list[i+1].to_i]
			p.z != nil ? perimeter = perimeter + Math.sqrt((p.x - p1.x)**2 +(p.y - p1.y)**2 + (p.z - p1.z)**2) :  perimeter = perimeter + Math.sqrt((p.x - p1.x)**2 +(p.y - p1.y)**2)   
		end	
		p=$points[polygon_list[polygon_list.length-1].to_i]
		p1=$points[polygon_list[0].to_i]
		p.z != nil ? perimeter = perimeter + Math.sqrt((p.x - p1.x)**2 +(p.y - p1.y)**2 + (p.z - p1.z)**2) :  perimeter = perimeter + Math.sqrt((p.x - p1.x)**2 +(p.y - p1.y)**2)   
		return perimeter
	end
	
	def to_mesh
		@polygon.to_s.toIfcObject
		xyz=""	
		polygon_list = @polygon.to_s.gsub(",","").sub("(","").sub(")","").split("#")
		polygon_list.each { |i|		
		o = $ifcObjects[i.to_i]
			if o != nil
				o.xyz
				xyz= xyz + o.x.to_s + " " + o.y.to_s + " " + o.z.to_s + " "
			else
				$log["<br>Line:" + __LINE__.to_s ]= " line_id :" +  o.class.to_s + ".to_mesh() object is null"	
			end
		}
		return xyz
	end
		
	def to_dae(objectPlacement=nil)
		Dae.to_dae(self,objectPlacement)
	end
	
	def to_dae_geometry(mesh_id="")
		@polygon.toIfcObject
		polygon_list = @polygon.gsub("#","").sub("(","").sub(")","").split(",")
		dae=""	
		if mesh_id == ""
			dae = dae + "<geometry id='" +  "IFCPOLYLOOP_mesh_" + @line_id.to_s + "'>"
		else
			dae = dae + "<geometry id='" +  mesh_id + "'>"
		end
		dae = dae + "<mesh><source id='s_" + @line_id.to_s + "'><float_array id='pos_arr" + @line_id.to_s + "' count='" + (polygon_list.length*3).to_s + "'>"
		xyz=""
		polygon_list.length.times do |i|
			next if i == ""				
		o = $ifcObjects[polygon_list[i].to_i]
		if o != nil
			xyz= xyz + o.x.to_s + " " + o.y.to_s + " " + o.z.to_s + " "
		else
			#puts "to_dae_geometry in class IfcPolyLine line:" + __LINE__.to_s
		end	
		end
		dae = dae + xyz				
		dae = dae + "</float_array><technique_common><accessor count='" + polygon_list.length.to_s + "' source='#pos_arr" + @line_id.to_s + "' stride='3'><param name='X' type='float'/><param name='Y' type='float' /><param name='Z' type='float' /></accessor></technique_common>"
		dae = dae + "</source>"
		
		dae = dae + "<source id='normals_" + @line_id.to_s + "'><float_array id='nor_arr" + @line_id.to_s + "' count='3'>" + get_normal
		dae = dae + "</float_array><technique_common><accessor source='#nor_arr" + @line_id.to_s + "' count='1' stride='3'><param name='X' type='float'/><param name='Y' type='float'/><param name='Z' type='float'/></accessor></technique_common></source>"
		
		dae = dae + "<vertices id='vertices_" + @line_id.to_s + "'>"
		dae = dae + "    <input semantic='POSITION' source='#s_" + @line_id.to_s + "'/>"
		dae = dae + "</vertices>"
		dae = dae + "<polylist count='" + (polygon_list.length).to_s + "' material='" + $dae_mat +  "'>"
		dae = dae + "    <input offset='0' semantic='VERTEX' source='#vertices_" + @line_id.to_s + "' />"
		dae = dae + "    <input offset='1' semantic='NORMAL' source='#normals_" + @line_id.to_s + "' />"
		dae = dae + "<vcount>" + (polygon_list.length).to_s + "</vcount>"
		dae = dae + " <p>"
		(polygon_list.length).times do |i|
			dae = dae + i.to_s + " 0 "
		end		
		dae = dae + "</p></polylist></mesh></geometry>"		
		return dae				
	end
	
	def to_dae_node(placement=nil)
		if placement != nil
			obj_localplacement = $ifcObjects[placement.delete("#").to_i]
		end	
		dae_node=""
		dae_node=dae_node + "<node name='" +  "IFCPOLYLOOP_" + @line_id.to_s + "'>"
		if obj_localplacement != nil
			obj_localplacement.xyz
			res= res + "<translate>" +  obj_localplacement.x.to_s + " " +  obj_localplacement.y.to_s + " "+  obj_localplacement.z.to_s + "</translate>"
		end
		dae_node=dae_node + "<instance_geometry url='#IFCPOLYLOOP_mesh_" + @line_id.to_s + "'>"
		dae_node=dae_node + "<bind_material>"
		dae_node=dae_node + "<technique_common>"
		dae_node=dae_node + "<instance_material symbol='" + $dae_mat +  "' target='#" + $dae_mat + "'>"
		#dae_node=dae_node + "<bind_vertex_input semantic='UVSET0' input_semantic='TEXCOORD' input_set='0' />"
		dae_node=dae_node + "</instance_material>"
		dae_node=dae_node + "</technique_common>"
		dae_node=dae_node + "</bind_material>"
		dae_node=dae_node + "</instance_geometry>"
		dae_node=dae_node + "</node>"				
		return dae_node
	end

	def area
		area=0
		@polygon.to_s.toIfcObject
		pnts=[]
		@polygon.to_s.gsub(",","").sub("(","").sub(")","").split("#").each { |p|
		pnts << p if p != ""
		}
		j=0
		(pnts.size-1).times do |i|
			j = j +1
			j= 0 if j== pnts.size
			p=$points[pnts[j].to_i]
			p1=$points[pnts[i].to_i]
			area += (p1.x + p.x)*(p1.y - p.y) if p1.z ==  p.z
			area += (p1.y + p.y)*(p1.z - p.z) if p1.x ==  p.x
			area += (p1.x + p.x)*(p1.z - p.z) if p1.y ==  p.y			
		end
		return ((area * 0.5).abs*$ifcUnit["Length"]*$ifcUnit["Length"])
	end
end