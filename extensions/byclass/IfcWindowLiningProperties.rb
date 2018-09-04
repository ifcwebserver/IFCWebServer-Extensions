class IFCWINDOWLININGPROPERTIES
	def  property_details
		res = ""  		
		res = res + "<table class='propertyset'>"
		res += "<tr><th>Name</th><td>" + @name + "</td></tr>"								if @name != "$"
		res += "<tr><th>globalId</th><td>" + @globalId + "</td></tr>" 				
		res += "<tr><td>LiningDepth</td><td>" + @liningDepth + "</td></tr>" 				if @liningDepth !=nil and  @liningDepth != "$"
		res += "<tr><td>LiningThickness</td><td>" + @liningThickness + "</td></tr>"			if @liningThickness !=nil and @liningThickness != "$"
		res += "<tr><td>TransomThickness</td><td>" + @transomThickness + "</td></tr>"		if @transomThickness != nil and @transomThickness != "$"
		res += "<tr><td>MullionThickness</td><td>" + @mullionThickness + "</td></tr>"		if @mullionThickness != nil and @mullionThickness != "$"
		res += "<tr><td>FirstTransomOffset</td><td>" + @firstTransomOffset + "</td></tr>"		if  @firstTransomOffset !=nil and @firstTransomOffset != "$"
		res += "<tr><td>SecondTransomOffset</td><td>" + @secondTransomOffset + "</td></tr>"		if @secondTransomOffset != nil and @secondTransomOffset != "$"
		res += "<tr><td>FirstMullionOffset</td><td>" + @firstMullionOffset + "</td></tr>"		if @firstMullionOffset !=nil and @firstMullionOffset != "$"
		res += "<tr><td>SecondMullionOffset</td><td>" + @secondMullionOffset + "</td></tr>"		if @secondMullionOffset !=nil and @secondMullionOffset != "$"
		#belloe is only for IFC4
		res += "<tr><td>LiningOffset</td><td>" + @liningOffset + "</td></tr>"		if @liningOffset != nil and @liningOffset != "$"
		res += "<tr><td>LiningToPanelOffsetX</td><td>" + @liningToPanelOffsetX + "</td></tr>"		if @liningToPanelOffsetX != nil and @liningToPanelOffsetX != "$"
		res += "<tr><td>LiningToPanelOffsetY</td><td>" + @liningToPanelOffsetY + "</td></tr>"		if @liningToPanelOffsetY != nil	and @liningToPanelOffsetY != "$"		
		res += "<tr><td>ShapeAspectStyle</td><td>" + @shapeAspectStyle + "</td></tr>"		if @shapeAspectStyle != "$"		
		res = res + "</table>"
		return res
	end
end