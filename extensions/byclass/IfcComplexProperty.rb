class IFCCOMPLEXPROPERTY
	def to_row
		res = "<tr>
			<th>ComplexProperty:<br><b>Name</b>:" + @name.to_s + 
			                   "<br><b>UsageName:</b>" + @usageName.to_s  
		res +=                 "</br><b>Description:</b>" + @description.to_s  if (@description.to_s != "$" and @description.to_s != "")
		res += "</th><td colspan='3'>" 
		res += "<table class='propertyset'>"
		@hasProperties.to_s.toIfcObject.each {  |k,o|
		res += o.to_row if o.respond_to?('to_row')
		}
		res + "</table></td></tr>"
	end
	
	def to_table
	res= "<table class='propertyset'>"
	res += to_row
	res += "</table>"	
	end
end