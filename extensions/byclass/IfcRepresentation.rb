class IFCREPRESENTATION
	def area
		@items_list = @items.delete("(").delete(")").gsub("#","").split(",")
		@items_list.toIfcObject
		if @representationIdentifier.upcase == "'BODY'"
			o=$ifcObjects[@items_list[@items_list.length].to_i]	
			if o.respond_to?('area')
			o.area
			else
			"n.s"
			end		
		elsif @representationIdentifier.upcase == "'ANNOTATION'"
		#TODO
		elsif @representationIdentifier.upcase == "'AXIS'"
		#TODO	
		elsif @representationIdentifier.upcase == "'FOOTPRINT'"		
		#TODO	
		else
		"n.s"
		end
	end
	
	def area_side	
		@items_list = @items.delete("(").delete(")").gsub("#","").split(",")
		@items_list.toIfcObject
		if @representationIdentifier == "'Body'"
			o=$ifcObjects[@items_list[@items_list.length].to_i]	
			if o.respond_to?('area_side')
			o.area_side.to_f.round_to(3)
			else
			"n.s"
			end		
		elsif @representationIdentifier.upcase == "'ANNOTATION'"
		#TODO
		elsif @representationIdentifier.upcase == "'AXIS'"
		#TODO	
		elsif @representationIdentifier.upcase == "'FOOTPRINT'"		
		#TODO	
		else
		"n.s"
		end
	end
	
	def volume
		@items_list = @items.delete("(").delete(")").gsub("#","").split(",")
		@items_list.toIfcObject
		if @representationIdentifier == "'Body'"
			o=$ifcObjects[@items_list[@items_list.length].to_i]	
			if o.respond_to?('volume')
			o.volume.to_f
			else
			"n.s"
			end
		elsif @representationIdentifier.upcase == "'ANNOTATION'"
		#TODO
		elsif @representationIdentifier.upcase == "'AXIS'"
		#TODO	
		elsif @representationIdentifier.upcase == "'FOOTPRINT'"		
		#TODO	
		else
		"n.s"
		end
	end
	
	def height
		@items_list = @items.delete("(").delete(")").gsub("#","").split(",")
		@items_list.toIfcObject	
		if @representationIdentifier == "'Body'"
			o=$ifcObjects[@items_list[@items_list.length].to_i]				
			if o.respond_to?('height')
			o.height
			else
			"n.s" + o.class.to_s
			end		
		elsif @representationIdentifier.upcase == "'ANNOTATION'"
		#TODO
		elsif @representationIdentifier.upcase == "'AXIS'"
		#TODO	
		elsif @representationIdentifier.upcase == "'FOOTPRINT'"		
		#TODO	
		else
		"n.s"
		end
	end
	
	def to_svg
		@items_list = @items.delete("(").delete(")").gsub("#","").split(",")
		@items_list.toIfcObject
		o=$ifcObjects[@items_list[items_list.length].to_i]
		if o.respond_to?('to_svg')
			o.to_svg
		else
		    $log["<br>Line:" + __LINE__.to_s ]= "  " +  o.class.to_s + "to_svg is not yet supported"
		end
	end
	
	def to_dae(objectPlacement=nil,*args)
		@items_list = @items.delete("(").delete(")").gsub("#","").split(",")
		@items_list.toIfcObject
		@items_list.each { |it|
		o=$ifcObjects[it.to_i]		
		if o.respond_to?('to_dae')
			Dae.to_dae(self,objectPlacement)			
		else
			$log["<br>" + __LINE__ + " Line:" + __LINE__.to_s ]= "  " +  o.class.to_s + " to_dae is not yet supported"					
		end
		}
	end
end