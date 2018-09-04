class IFCWINDOWSTYLE
	def  property_details
		res = ""  		
		res = res + "<table class='propertyset'>"
		res += "<tr><th>Style Name</th><td>" + fix_it(@name) + "</td></tr>"								if @name != "$"					
		res += "<tr><th>ConstructionType</th><td>" + @constructionType + "</td></tr>"				if @constructionType !=nil and @constructionType != "$"		
		res += "<tr><th>OperationType</th><td>" + @operationType + "</td></tr>" 			if @operationType !=nil and @operationType != "$"				
		res += "<tr><th>parameterTakesPrecedence</th><td>" + @parameterTakesPrecedence + "</td></tr>" 					if @parameterTakesPrecedence !=nil and @parameterTakesPrecedence != "$"
		res += "<tr><th>Sizeable</th><td>" + @sizeable + "</td></tr>" 			if @sizeable !=nil and @sizeable != "$"		
		res = res + "</table>"
		return res
	end
end