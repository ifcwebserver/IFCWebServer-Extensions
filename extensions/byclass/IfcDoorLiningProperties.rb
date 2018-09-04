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
		res += "<tr><th>LiningDepth</th><td>" + @liningDepth + "</td></tr>" 						if @liningDepth != "$"
		res += "<tr><th>LiningThickness</th><td>" + @liningThickness + "</td></tr>"					if @liningThickness != "$"
		res += "<tr><th>ThresholdDepth</th><td>" + @thresholdDepth + "</td></tr>"					if @thresholdDepth != "$"
		res += "<tr><th>ThresholdThickness</th><td>" + @thresholdThickness + "</td></tr>" 			if @thresholdThickness != "$"
		res += "<tr><th>TransomThickness</th><td>" + @transomThickness + "</td></tr>"				if @transomThickness != "$"
		res += "<tr><th>TransomOffset</th><td>" + @transomOffset + "</td></tr>"						if @transomOffset != "$"
		res += "<tr><th>LiningOffset</th><td>" + @liningOffset + "</td></tr>"						if @liningOffset != "$"
		res += "<tr><th>ThresholdOffset</th><td>" + @thresholdOffset + "</td></tr>"					if @thresholdOffset != "$"
		res += "<tr><th>CasingThickness</th><td>" + @casingThickness + "</td></tr>"					if @casingThickness != "$"
		res += "<tr><th>CasingDepth</th><td>" + @casingDepth + "</td></tr>"							if @casingDepth != "$"
		res += "<tr><th>ShapeAspectStyle</th><td>" + @shapeAspectStyle + "</td></tr>"				if @shapeAspectStyle != "$"
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