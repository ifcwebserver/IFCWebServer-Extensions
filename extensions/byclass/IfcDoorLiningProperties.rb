class IFCDOORLININGPROPERTIES
	def initialize1(args=[])
		@definesOccurrence.to_s.toIfcObject.each {|k,v|		
		relatingP_Obl = @definesType.to_s.to_obj
		relatingP_Obl.attach_to_obj(v)	if relatingP_Obl.respond_to?("attach_to_obj")		
		}	
	end	
	def  property_details
		res = ""  		
		res = res + "<table width='98%' class='propertyset'>\n"
		res += "<tr><th>Name</th><td>" + @name + "</td></tr>"										if @name != "$"
		res += "<tr><th>globalId</th><td>" + @globalId + "</td></tr>" 				
		res += "<tr><td>LiningDepth</td><td>" + @liningDepth + "</td></tr>" 						if @liningDepth != "$"
		res += "<tr><td>LiningThickness</td><td>" + @liningThickness + "</td></tr>"					if @liningThickness != "$"
		res += "<tr><td>ThresholdDepth</td><td>" + @thresholdDepth + "</td></tr>"					if @thresholdDepth != "$"
		res += "<tr><td>ThresholdThickness</td><td>" + @thresholdThickness + "</td></tr>" 			if @thresholdThickness != "$"
		res += "<tr><td>TransomThickness</td><td>" + @transomThickness + "</td></tr>"				if @transomThickness != "$"
		res += "<tr><td>TransomOffset</td><td>" + @transomOffset + "</td></tr>"						if @transomOffset != "$"
		res += "<tr><td>LiningOffset</td><td>" + @liningOffset + "</td></tr>"						if @liningOffset != "$"
		res += "<tr><td>ThresholdOffset</td><td>" + @thresholdOffset + "</td></tr>"					if @thresholdOffset != "$"
		res += "<tr><td>CasingThickness</td><td>" + @casingThickness + "</td></tr>"					if @casingThickness != "$"
		res += "<tr><td>CasingDepth</td><td>" + @casingDepth + "</td></tr>"							if @casingDepth != "$"
		res += "<tr><td>ShapeAspectStyle</td><td>" + @shapeAspectStyle + "</td></tr>"				if @shapeAspectStyle != "$"
		#bellow is only for IFC4		
		res += "<tr><td>LiningToPanelOffsetX</td><td>" + @liningToPanelOffsetX + "</td></tr>"		if @liningToPanelOffsetX != nil and @liningToPanelOffsetX != "$"
		res += "<tr><td>LiningToPanelOffsetY</td><td>" + @liningToPanelOffsetY + "</td></tr>"		if @liningToPanelOffsetY != nil	and @liningToPanelOffsetY != "$"
		res = res + "\n</table>"
		return res
	end	
	def attach_to_obj(obj)			
		obj.instance_variable_set("@ext_liningDepth",@liningDepth)
		obj.instance_variable_set("@ext_liningThickness",@liningThickness)	
		obj.instance_variable_set("@ext_doorLeafThickness",@liningDepth-@liningToPanelOffsetY) if @liningToPanelOffsetY != nil	and @liningToPanelOffsetY != "$" 		
	end
end