class IFCBOUNDINGBOX
	def to_dae(objectPlacement=nil,*args)
	#doc:<div class='documentaion' >convert the geometry data of IfcBoundingBox object to COLLADA format</div>
		Dae.to_dae(self,objectPlacement)		
	end
	
	def  corner_xyz
		@corner.toIfcObject
		o = $points[@corner.delete("#").to_i]
		"(" +o.x.to_s + "," + o.y.to_s + "," + o.z.to_s + ")"
	end
	
	def x_min
	@corner.toIfcObject
	o = $points[@corner.delete("#").to_i]
	o.x.round_to(3)
	end
	
	def x_max
	@corner.toIfcObject
	o = $points[@corner.delete("#").to_i]
	(o.x + @xDim.to_f).round_to(3)
	end
	
	def y_min
	@corner.toIfcObject
	o = $points[@corner.delete("#").to_i]
	o.y.round_to(3)
	end
	
	def y_max
	@corner.toIfcObject
	o = $points[@corner.delete("#").to_i]
	(o.y + @yDim.to_f).round_to(3)
	end
	
	def z_min
	@corner.toIfcObject
	o = $points[@corner.delete("#").to_i]
	o.z.round_to(3)
	end
	
	def z_max
	@corner.toIfcObject
	o = $points[@corner.delete("#").to_i]
	(o.z + @zDim.to_f).round_to(3)
	end
	
	def volume
	#doc:<div class='documentaion' >return the volume of the BoundingBox object</div>
	(@xDim.to_f*@yDim.to_f*@zDim.to_f).round_to(3)	
	end
	
	def center
	end
#private	
	def to_dae_geometry
		@corner.toIfcObject
		dae=""			
		dae = dae + "<geometry id='" +  "IFCBOUNDINGBOX_mesh_" + @line_id.to_s + "'>"
		dae = dae + "<mesh><source id='s_" + @line_id.to_s + "'><float_array id='pos_arr" + @line_id.to_s + "' count='24'>"	
		o = $points[@corner.delete("#").to_i]
		dx=@xDim.to_f
		dy=@yDim.to_f
		dz=@zDim.to_f
		xyz= 		o.x.to_s + " " + 			o.y.to_s + " " + 		o.z.to_s + " "
		xyz= xyz + (o.x.to_f + dx).to_s + " " + o.y.to_s + " " + o.z.to_s + " "
		xyz= xyz + (o.x + dx).to_s  + " " 	 + (o.y + dy).to_s  + " " + o.z.to_s + " "
		xyz= xyz + o.x.to_s + " " + (o.y + dy).to_s + " " + o.z.to_s + " "
		xyz= xyz + o.x.to_s + " " + o.y.to_s + " " + (o.z + dz).to_s + " "
		xyz= xyz + (o.x + dx).to_s + " " + o.y.to_s + " " + (o.z + dz).to_s + " "
		xyz= xyz + (o.x + dx).to_s  + " " + (o.y + dy).to_s  + " " + (o.z + dz).to_s + " "
		xyz= xyz + o.x.to_s + " " + (o.y + dy).to_s + " " + (o.z + dz).to_s			
		dae = dae + xyz				
		dae = dae + "</float_array><technique_common><accessor count='8' source='#pos_arr" + @line_id.to_s + "' stride='3'><param name='X' type='float'/><param name='Y' type='float' /><param name='Z' type='float' /></accessor></technique_common>"
		dae = dae + "</source>"
		dae = dae + "<vertices id='vertices_" + @line_id.to_s + "'>"
		dae = dae + "    <input semantic='POSITION' source='#s_" + @line_id.to_s + "'/>"
		dae = dae + "</vertices>"	
		dae = dae + "<source id='normals_" + @line_id.to_s + "'><float_array id='nor_arr" + @line_id.to_s + "' count='18'>" + "0 0 -1 0 0 1 1 0 0 0 -1 0 -1 0 0 0 1 0"
		dae = dae + "</float_array><technique_common><accessor source='#nor_arr" + @line_id.to_s + "' count='6' stride='3'><param name='X' type='float'/><param name='Y' type='float'/><param name='Z' type='float'/></accessor></technique_common></source>"
		dae = dae + "<polylist count='6' material='Material'>"
		dae = dae + "    <input offset='0' semantic='VERTEX' source='#vertices_" + @line_id.to_s + "' />"
		dae = dae + "    <input offset='1' semantic='NORMAL' source='#normals_" + @line_id.to_s + "' />"
		dae = dae + "<vcount>4 4 4 4 4 4</vcount>"
		dae = dae + " <p>0 0 1 0 2 0 3 0 4 1 7 1 6 1 5 1 0 2 4 2 5 2 1 2 1 3 5 3 6 3 2 3 2 4 6 4 7 4 3 4 4 5 0 5 3 5 7 5</p></polylist></mesh></geometry>"		
		return dae				
	end

	def to_dae_node(placement=nil)
		#Dae.to_dae_node(self,@corner)
		Dae.to_dae_node(self,nil)
	end	
end