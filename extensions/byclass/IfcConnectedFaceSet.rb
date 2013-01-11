class IFCCONNECTEDFACESET 
	def to_dae(objectPlacement=nil, *args)
		@cfsFaces.toIfcObject
		@cfsFaces_list = @cfsFaces.delete("(").delete(")").gsub("#","").split(",")	
		Dae.to_dae(self,objectPlacement)		
	end	
		
	def to_dae_geometry(mesh_id="")
		@cfsFaces.toIfcObject
		@cfsFaces_list = @cfsFaces.delete("(").delete(")").gsub("#","").split(",")		
		dae =""
		count=0
		polylist_count=0
		mesh_arr =""
		nor_arr =""
		vcount = ""		
		@cfsFaces_list.each { |face|
		next if face == ""
		obj= $ifcObjects[face.to_i]
			if obj.respond_to?('to_mesh')
				mesh_xyz	= obj.to_mesh
				nor_arr +=	obj.get_normal				
				mesh_arr += mesh_xyz
				mesh_count = mesh_xyz.split(" ").to_a.size	
				count += mesh_count
				vcount	= vcount +(mesh_count/3).to_s + " "
				polylist_count += 1	
			else
				$log["<br>Line:" + __LINE__.to_s ]= " line_id :" +  obj.class.to_s + ".to_mesh() is not yet implemented"
			end
		}
		dae = dae + "<geometry id=\"" +  self.class.to_s + "_mesh_" + @line_id.to_s + "\">"
		dae = dae + "\n<mesh>\n<source id=\"s_" + @line_id.to_s + "\">\n\t<float_array id=\"pos_arr" + @line_id.to_s + "\" count=\"" + count.to_s + "\">"
		dae = dae + mesh_arr		
		dae = dae + "</float_array>\n\t<technique_common>\n\t\t<accessor count=\"" + (count/3).to_s + "\" source=\"#pos_arr" + @line_id.to_s 
		dae = dae + "\" stride='3'>\n\t\t<param name='X' type='float'/>\n\t\t<param name='Y' type='float' />"
		dae = dae + "\n\t\t<param name='Z' type='float' />\n\t</accessor>\n</technique_common>\n"
		dae = dae + "</source>\n"		
		dae = dae + "<source id=\"normals_" + @line_id.to_s + "\">\n<float_array id=\"nor_arr" + @line_id.to_s + "\" count=\"" + (polylist_count*3).to_s + "\">" + nor_arr
		dae = dae + "</float_array>\n<technique_common>\n<accessor source=\"#nor_arr" + @line_id.to_s + "\" count=\"" + polylist_count.to_s 
		dae = dae + "\" stride=\"3\">\n<param name=\"X\" type=\"float\"/>\n<param name=\"Y\" type=\"float\"/>\n<param name=\"Z\" type=\"float\"/>"
		dae = dae + "\n</accessor>\n</technique_common>\n</source>\n"		
		dae = dae + "<vertices id=\"vertices_" + @line_id.to_s + "\">\n"
		dae = dae + "    <input semantic=\"POSITION\" source=\"#s_" + @line_id.to_s + "\"/>\n"
		dae = dae + "</vertices>\n"				
		dae = dae + "<polylist count=\"" + polylist_count.to_s + "\" material='Material' >\n"
		dae = dae + "    <input offset=\"0\" semantic=\"VERTEX\" source=\"#vertices_" + @line_id.to_s + "\" />\n"
		dae = dae + "    <input offset=\"1\" semantic=\"NORMAL\" source=\"#normals_" + @line_id.to_s + "\" />\n"
		dae = dae + "<vcount>" + vcount + "</vcount>"
		dae = dae + " <p>"		
		(count/3).times do |i|
			dae = dae + i.to_s + " 0 "
		end		
		dae = dae + "</p>\n</polylist>\n</mesh>\n</geometry>"		
		return dae		
	end	
	
	def to_dae_node(placement=nil)
		Dae.to_dae_node(self,placement,"")			
	end
end