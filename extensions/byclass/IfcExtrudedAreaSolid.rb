class IFCEXTRUDEDAREASOLID
	def area
		@sweptArea.toIfcObject
		o=$ifcObjects[@sweptArea.delete("#").to_i]
		if o.respond_to?('area')
			@area=o.area.to_f		
		else
			$log["<br>" + __FILE__.to_s + " Line:" + __LINE__.to_s ]= "  " +  o.class.to_s + ".area() is not yet supported"	
		end	
	end
	
	def perimeter
		@sweptArea.toIfcObject
		o=@sweptArea.to_obj
		if o.respond_to?('perimeter')
			o.perimeter.to_f
		else
			$log["<br>" + __FILE__.to_s + " Line:" + __LINE__.to_s ]= "  " +  o.class.to_s + ".area() is not yet supported"
		end
	end
	
	def diameter
		@sweptArea.toIfcObject
		o=$ifcObjects[@sweptArea.delete("#").to_i]
		if o.respond_to?('diameter')
			o.perimeter.to_f
		else
			$log["<br>" + __FILE__.to_s + " Line:" + __LINE__.to_s ]= "  " +  o.class.to_s + ".diameter() is not yet supported"
		end		
	end	
	
	def area_side
		@sweptArea.toIfcObject
		o=$ifcObjects[@sweptArea.delete("#").to_i]
		if o.respond_to?('perimeter')			
			(o.perimeter.to_f* @depth.to_f*$ifcUnit["Length"]).to_f
		else
			$log["<br>" + __FILE__.to_s + " Line:" + __LINE__.to_s ]= "  " +  o.class.to_s + ".perimeter() is not yet supported --> area_side can not be calculated for IFCEXTRUDEDAREASOLID "
		end		
	end
	
	def volume
		@sweptArea.toIfcObject
		o=$ifcObjects[@sweptArea.delete("#").to_i]
		if o.respond_to?('area')			
			(o.area.to_f *  @depth.to_f*$ifcUnit["Length"].to_f * $ifcUnit["Length"].to_f).to_f 
		else
			$log["<br>" + __FILE__.to_s + " Line:" + __LINE__.to_s ]= "  " +  o.class.to_s + ".area() is not yet supported --> volume can not be calculated for IFCEXTRUDEDAREASOLID "
		end				
	end
	
	def height			
		(@depth.to_f*$ifcUnit["Length"]).to_f
	end
	
	def to_dae(objectPlacement=nil,*args)
		Dae.to_dae(self,objectPlacement)
		return
		@sweptArea.to_s.toIfcObject
		o=$ifcObjects[@sweptArea.delete("#").to_i]
		if o.respond_to?('xyz_array') == false
			$log["<br>Line:" + __LINE__.to_s ]= "  " +  o.class.to_s + " xyz_array is not yet supported"
			return ""
		end
		$dae_file = File.open('dae/'  + $username + "/" + $ifc_file_name + "_IfcExtrudedAreaSolid_" + @line_id.to_s + '.dae', 'w')	
		$dae_file.puts "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\" ?>"
		$dae_file.puts "\n<COLLADA xmlns=\"http://www.collada.org/2005/11/COLLADASchema\" version=\"1.4.1\">\n<asset>\n<contributor>\n"
		$dae_file.puts "<authoring_tool>IFC Web  Server v.1</authoring_tool>"
		$dae_file.puts "\n</contributor>\n<created>" + Time.now.strftime("%Y-%m-%dT%H:%M:%S") + "</created>"
		$dae_file.puts "\n<modified>" + Time.now.strftime("%Y-%m-%dT%H:%M:%S")  + "</modified>"
		$dae_file.puts "\n<unit meter=\"1.0\" name=\"meters\" />\n<up_axis>Z_UP</up_axis>\n"
		$dae_file.puts "</asset>\n<library_visual_scenes>\n"
		$dae_file.puts "<visual_scene id=\"ifcwebserver\">\n"
		$dae_file.puts to_dae_node(ifclocalplacement)
		$dae_file.puts "</visual_scene>\n</library_visual_scenes>\n<library_geometries>\n"
		$dae_file.puts to_dae_geometry
		$dae_file.puts "</library_geometries>\n"
		$dae_file.puts Dae.material_section
		$dae_file.puts "<scene>\n<instance_visual_scene url=\"#ifcwebserver\" />\n</scene>\n</COLLADA>"
		$dae_file.close				
	end
	
	def xyz_min_max(location=[0,0,0])
		@sweptArea.toIfcObject
		obj=$ifcObjects[@sweptArea.delete("#").to_i]
		xyz_arr=obj.xyz_array
		if xyz_arr == nil			
			$log["<br>" + __FILE__.to_s + " Line:" + __LINE__.to_s ]= "  " +  obj.class.to_s + " xyz_array= nil"	
			return ""
		end	
		xyz_array1=xyz_arr.join(" ").to_s
		xyz_array1.gsub!("  "," ")
		xyz_array= (xyz_array1.gsub("z", "0") + " " + xyz_array1.gsub("z", @depth.to_s)).split(' ')	
		n=xyz_array.size/3
		x=y=z=[]
		i=0
		n.times {
		x << location[0].to_f + xyz_array[i].to_f
		y << location[1].to_f + xyz_array[i+1].to_f
		z << location[2].to_f + xyz_array[i+2].to_f
		i +=3
		}
		return "<xmin>" + x.min.to_s + "</xmin><xmax>" + x.max.to_s + "</xmax><ymin>" + y.min.to_s + "</ymin><ymax>" + y.max.to_s + "</ymax><zmin>" +
		z.min.to_s + "</zmin><zmax>" + z.max.to_s + "</zmax>"	
	end
	
	def to_dae_geometry(mesh_id = "")
		@sweptArea.toIfcObject		
		obj=$ifcObjects[@sweptArea.delete("#").to_i]		
		if obj.respond_to?("xyz_array")
			xyz_arr=obj.xyz_array 
		else
		 #return ""
		end
		if xyz_arr==nil
			puts obj.class.to_s + "xyz_array not implemented yet"
			return "IFCEXTRUDEDAREASOLID.to_dae_geometry:xyz_arr = nil"
		end	
		if xyz_arr.include?("NilClass.xyz_array")
		#return ""
		end	
		xyz_array1=xyz_arr.join(" ").to_s
		xyz_array1=xyz_arr.join		
		xyz_array= xyz_array1.gsub("z", "0") + " " + xyz_array1.gsub("z", @depth.to_s)	
		n=xyz_arr.size/3		
		nor_arr = "0 0 -1 0 0 1" 
		n.times {  nor_arr += " 0.5 0.5 0" }	
		if mesh_id == ""
			res ="<geometry id=\"" + self.class.to_s + "_" + self.line_id.to_s + "\">\n<mesh>\n<source id=\"source_pos_" + @line_id.to_s + "\">\n"
		else
			res ="<geometry id=\"" + mesh_id + "\">\n<mesh>\n<source id=\"source_pos_" + @line_id.to_s + "\">\n"
		end				
		res=res  + "<float_array id=\"arr_pos_line_id\" count=\"6n\">xyz_array</float_array>".sub("6n",(6*n).to_s).gsub("line_id",@line_id.to_s).sub("xyz_array",xyz_array)
		res = res  + "<technique_common>\n"
		res = res  + "<accessor count=\"2n\" source=\"#arr_pos_line_id\" stride=\"3\">\n".sub("2n",(2*n).to_s).sub("line_id",@line_id.to_s)
		res = res  + "<param name=\"X\" type=\"float\" />\n"
		res = res  + "<param name=\"Y\" type=\"float\" />\n"
		res = res  + "<param name=\"Z\" type=\"float\" />\n"
		res = res  + "</accessor>\n"
		res = res  + "</technique_common>\n"
		res = res  + "</source>\n"
		res = res + "<source id=\"normals_" + @line_id.to_s + "\">\n<float_array id=\"nor_arr" + @line_id.to_s + "\" count=\"" + ((n+2)*3).to_s + "\">" + nor_arr
		res = res + "</float_array>\n<technique_common>\n<accessor source=\"#nor_arr" + @line_id.to_s + "\" count=\"" + (n+2).to_s + "\" stride=\"3\">"
		res = res + "\n<param name=\"X\" type=\"float\"/>"
		res = res + "\n<param name=\"Y\" type=\"float\"/>\n<param name=\"Z\" type=\"float\"/>\n</accessor>\n</technique_common>\n</source>\n"
		res = res  + "<vertices id=\"vertices_line_id\">\n".sub("line_id",@line_id.to_s)
		res = res  + "<input semantic=\"POSITION\" source=\"#source_pos_line_id\" />\n".sub("line_id",@line_id.to_s)
		res = res  + "</vertices>\n"
		res = res  + "<polylist count=\"" + (n + 2).to_s + " \" material='Material' >\n".sub("n+2",(n+2).to_i.to_s)
		res = res  + "<input offset=\"0\" semantic=\"VERTEX\" source=\"#vertices_line_id\" />\n".sub("line_id",@line_id.to_s)
		res = res + " <input offset=\"1\" semantic=\"NORMAL\" source=\"#normals_" + @line_id.to_s + "\" />\n"
		res = res  + "<vcount>" + n.to_s + " " + n.to_s
		n.times { res = res + " 4" }
		res = res  + "</vcount>\n"
		res = res  + "<p>"	
		n.times { |x| res = res + x.to_s + " 0 " }
		n.times { |x| res = res + (x+n).to_s + " 1 " }
		#0 0 1 0 2 0 3 0 4 1 7 1 6 1 5 1 0 2 4 2 5 2 1 2 1 3 5 3 6 3 2 3 2 4 6 4 7 4 3 4 4 5 0 5 3 5 7 5	
		normal_index= 2 
		i=0
		(n-1).times {
		res = res + i.to_s + " " + normal_index.to_s + " " + (i+1).to_s + " " + normal_index.to_s + " " +  (n+i+1).to_s + " " 
		res = res +  normal_index.to_s + " " + (n+i).to_s + " " + normal_index.to_s + " "
		normal_index += 1
		i +=1
		}
	    res =res + (n-1).to_s + " " + normal_index.to_s + " 0 " + normal_index.to_s +  " " + n.to_s + " " + normal_index.to_s +  " " + (2*n-1).to_s + " " + normal_index.to_s
	    res =res + "</p>\n"
	     res =res + "</polylist>\n</mesh>\n</geometry>"
		return res
	end

	def to_dae_node(ifclocalplacement=nil)
		@sweptArea.toIfcObject
		o=$ifcObjects[@sweptArea.delete("#").to_i]
		if o.respond_to?('xyz_array') == false
			$log["<br>Line:" + __LINE__.to_s ]= "  " +  o.class.to_s + " xyz_array is not yet supported"
			return ""
		end
		dx=dy=dz=0
		if ifclocalplacement != nil
			obj_localplacement = $ifcObjects[ifclocalplacement.delete("#").to_i]
			obj_localplacement.location
			dx = obj_localplacement.x.to_f
			dy = obj_localplacement.y.to_f
			dz = obj_localplacement.z.to_f
		end
		obj_pos= $ifcObjects[@position.delete("#").to_i]	
		res="<node id=\"IFCEXTRUDEDAREASOLID_node_line_id\" name=\"IFCEXTRUDEDAREASOLID_Obj_line_id\">".gsub("line_id", @line_id.to_s)
		
		if obj_pos != nil	
			dx += obj_pos.x.to_f
			dy += obj_pos.y.to_f
			dz += obj_pos.z.to_f
		end
		if obj_localplacement != nil or obj_pos != nil
			res= res + "<translate>" +  dx.to_s + " " +  dy.to_s + " "+  dz.to_s + "</translate>"
		end
		#axisObj= $ifcObjects[obj_pos.axis.delete("#").to_i]
		#if axisObj.dir1 == 0 and axisObj.dir2 = -1 and axisObj.dir3 = 0 
		#	res= res + "<rotate>1.0 0.0 0.0 -90</rotate>"
		#end	
		res=res +   "<instance_geometry url=\"#IFCEXTRUDEDAREASOLID_line_id\">\n".sub("line_id",@line_id.to_s)
		res=res +   "<bind_material>\n<technique_common>\n<instance_material symbol='Material' target=\"#" + $dae_mat + "\"/>\n</technique_common>\n</bind_material>"
		res=res +   "</instance_geometry>"
		res=res +   "</node>"
		return res
	end

	def svg(scale=1,transformation="")
		@sweptArea.toIfcObject		
		o=$ifcObjects[@sweptArea.delete("#").to_i]
		if o.respond_to?('svg')
			pos = @position.to_obj
			o.svg(scale,'transform="translate(' + pos.x.to_s + ',' +  pos.y.to_s + ') scale(' + scale.to_s + ')"' )
		else
			$log["<br>Line:" + __LINE__.to_s ]= "  " +  o.class.to_s + "svg() is not yet supported"			
		end
	end
	
	def to_svg
		@sweptArea.toIfcObject		
		o=$ifcObjects[@sweptArea.delete("#").to_i]
		if o.respond_to?('to_svg')
			o.to_svg
		else
			$log["<br>Line:" + __LINE__.to_s ]= "  " +  o.class.to_s + "to_svg is not yet supported"			
		end
	end	
end