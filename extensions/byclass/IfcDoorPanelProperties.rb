class IFCDOORPANELPROPERTIES
	def  property_details
		res = ""  		
		res = res + "<table width='98%' class='propertyset'>\n"
		res += "<tr><th>Name</th><td>" + @name + "</td></tr>"							if @name != "$"
		res += "<tr><th>globalId</th><td>" + @globalId + "</td></tr>" 				
		res += "<tr><td>PanelDepth</td><td>" + @panelDepth + "</td></tr>" 				if @panelDepth != "$"
		res += "<tr><td>PanelOperation</td><td>" + @panelOperation + "</td></tr>"		if @panelOperation != "$"
		res += "<tr><td>PanelPosition</td><td>" + @panelPosition + "</td></tr>"			if @panelPosition != "$"
		res += "<tr><td>PanelWidth</td><td>" + @panelWidth + "</td></tr>" 				if @panelWidth != "$"
		res += "<tr><td>ShapeAspectStyle</td><td>" + @shapeAspectStyle + "</td></tr>"	if @shapeAspectStyle != "$"		
		res = res + "\n</table>"
		return res
	end
	
	def attach_to_obj(obj)			
		obj.instance_variable_set("@ext_panelDepth",@panelDepth)
		obj.instance_variable_set("@ext_panelWidth",@panelWidth)
		obj.instance_variable_set("@ext_panelPosition",@panelPosition)		
		obj.instance_variable_set("@ext_panelOperation",@panelOperation)			
	end
	
end