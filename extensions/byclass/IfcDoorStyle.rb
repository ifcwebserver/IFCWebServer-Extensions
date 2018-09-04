class IFCDOORSTYLE
	def  property_details
		res = ""  		
		res = res + "<table class='propertyset'>"
		res += "<tr><th>Name</th><td>" + @name + "</td></tr>"								if @name != "$"
		res += "<tr><th>globalId</th><td>" + @globalId + "</td></tr>" 				
		res += "<tr><td>OperationType</td><td>" + @operationType + "</td></tr>" 			if @operationType !=nil and @operationType != "$"		
		res += "<tr><td>ConstructionType</td><td>" + @constructionType + "</td></tr>"				if @constructionType !=nil and @constructionType != "$"		
		res += "<tr><td>parameterTakesPrecedence</td><td>" + @parameterTakesPrecedence + "</td></tr>" 					if @parameterTakesPrecedence !=nil and @parameterTakesPrecedence != "$"
		res += "<tr><td>Sizeable</td><td>" + @sizeable + "</td></tr>" 			if @sizeable !=nil and @sizeable != "$"		
		res = res + "</table>"
		return res
	end	
end