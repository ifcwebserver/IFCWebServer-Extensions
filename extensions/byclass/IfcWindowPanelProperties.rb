class IFCWINDOWPANELPROPERTIES
	def  property_details
		res = ""  		
		res = res + "<table class='propertyset'>"
		res += "<tr><th>Name</th><td>" + @name + "</td></tr>"								if @name != "$"
		res += "<tr><th>globalId</th><td>" + @globalId + "</td></tr>" 				
		res += "<tr><td>OperationType</td><td>" + @operationType + "</td></tr>" 			if @operationType !=nil and @operationType != "$"		
		res += "<tr><td>PanelPosition</td><td>" + @panelPosition + "</td></tr>"				if @panelPosition !=nil and @panelPosition != "$"
		res += "<tr><td>FrameDepth</td><td>" + @frameDepth + "</td></tr>" 					if @frameDepth !=nil and @frameDepth != "$"
		res += "<tr><td>FrameThickness</td><td>" + @frameThickness + "</td></tr>" 			if @frameThickness !=nil and @frameThickness != "$"
		res += "<tr><td>ShapeAspectStyle</td><td>" + @shapeAspectStyle + "</td></tr>"		if @shapeAspectStyle !=nil and @shapeAspectStyle != "$"		
		res = res + "</table>"
		return res
	end
end