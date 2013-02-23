class IFCWINDOWSTYLE
	def  property_details
		res = ""  		
		res = res + "<table class='propertyset'>\n"
		res += "<tr><th>Name</th><td>" + fix_it(@name) + "</td></tr>"								if @name != "$"
		res += "<tr><th>globalId</th><td>" + @globalId + "</td></tr>" 				
		res += "<tr><td>ConstructionType</td><td>" + @constructionType + "</td></tr>"				if @constructionType !=nil and @constructionType != "$"		
		res += "<tr><td>OperationType</td><td>" + @operationType + "</td></tr>" 			if @operationType !=nil and @operationType != "$"				
		res += "<tr><td>parameterTakesPrecedence</td><td>" + @parameterTakesPrecedence + "</td></tr>" 					if @parameterTakesPrecedence !=nil and @parameterTakesPrecedence != "$"
		res += "<tr><td>Sizeable</td><td>" + @sizeable + "</td></tr>" 			if @sizeable !=nil and @sizeable != "$"		
		res = res + "\n</table>"
		return res
	end
end