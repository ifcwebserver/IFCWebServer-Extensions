class IFCPROPERTYDEFINITION
	def to_details(str="")	
		return if @name == nil
		res = ""  		
		res = res + "<table  class='propertyset'>"
		res = res + "<tr><th colspan=2>" + @name.strip[1..-2] + "</td></tr>" if @name != "$"		
		str.toIfcObject.each { |k,obj|				
			if ($include_properties.size == 0 or $include_properties.include? fix_it(obj.name)) and not $ignore_properties.include? fix_it(obj.name)
				res = res +  obj.to_row	if obj.respond_to?("to_row")
			end		
		}
		#res = res + "<tr><th>globalId</th><td>" + @globalId[1..-2] + "</td></tr>"
		res = res + "</table>"
		return res	
	end
	
	def to_details_xml(str="")			
		return if @name == nil	
		res = "" 		
		str.toIfcObject.each { |k,obj|								
			if ($include_properties.size == 0 or $include_properties.include? fix_it(obj.name)) and not $ignore_properties.include? fix_it(obj.name)
				res = res +  obj.to_xml	if obj.respond_to?("to_xml")
			end
		}		
		return res			
	end
	
	def names_values(str="")
	return if @name == nil	
		res_names = []
		res_values = []
		str.toIfcObject.each { |k,obj|								
		if ($include_properties.size == 0 or $include_properties.include? fix_it(obj.name)) and not $ignore_properties.include? fix_it(obj.name)
			res_names <<  "'" + obj.valid_name + "'"	if obj.respond_to?("valid_name")
			res_values <<  "'" + obj.valid_value	+ "'" if obj.respond_to?("valid_value")
		end
		}		
		res={}
		res['names']  = res_names.join(",") 
		res['values'] = res_values.join(",")			
		return res		
	end
	
end