class IFCDOORPANELPROPERTIES
	def  property_details
		res = ""  		
		res = res + "<table class='propertyset'>"
		res += "<tr><th>Name</th><td>" + @name + "</td></tr>"							if @name != "$"
		res += "<tr><th>globalId</th><td>" + @globalId + "</td></tr>" 				
		res += "<tr><th>PanelDepth</th><td>" + @panelDepth + "</td></tr>" 				if @panelDepth != "$"
		res += "<tr><th>PanelOperation</th><td>" + @panelOperation + "</td></tr>"		if @panelOperation != "$"
		res += "<tr><th>PanelPosition</th><td>" + @panelPosition + "</td></tr>"			if @panelPosition != "$"
		res += "<tr><th>PanelWidth</th><td>" + @panelWidth + "</td></tr>" 				if @panelWidth != "$"
		res += "<tr><th>ShapeAspectStyle</th><td>" + @shapeAspectStyle + "</td></tr>"	if @shapeAspectStyle != "$"		
		res = res + "</table>"
		return res
	end
	
	def attach_to_obj(obj)			
		obj.instance_variable_set("@ext_panelDepth",@panelDepth)
		obj.instance_variable_set("@ext_panelWidth",@panelWidth)
		obj.instance_variable_set("@ext_panelPosition",@panelPosition)		
		obj.instance_variable_set("@ext_panelOperation",@panelOperation)			
	end
	
end