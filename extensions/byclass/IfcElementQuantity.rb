class IFCELEMENTQUANTITY
	def to_details(str="")	
		return if @name == nil
		res = ""  
		#res = res + "<br><b>Description:</b>" + @description + "<br>" if @description != "$"
		#res = res +"<b>GlobalId:</b>" + @globalId 	+ "<br>"	
		#res = res +"<b>IFC_LineID:</b>" + @line_id.to_s 		
		res = res + "<table  class='propertyset'>\n"
		res = res + "<tr><th colspan=3>" + @name.strip[1..-2] + "</th></tr>" if @name != "$"
		res = res + "<tr><th></th><th>Value</th><th>Unit</th></tr>"
		str.toIfcObject.each { |k,obj|
			res = res +  obj.to_row	
		}
		res = res + "\n</table>"
		return res	
	end
	
	def property_details		
		to_details(@quantities)		
	end
	
	def property_details_xml
		property_details
	end
	
	def to_details_xml(str="")	
		to_details(str)
	end
	
	def attach_to_obj(obj)		
		@quantities.to_s.toIfcObject.each { |k,v|
		v.attach_to_obj(obj) if v.respond_to?("attach_to_obj")
		}
	end
end