class IFCQUANTITYAREA
	def to_row
		"<tr>\n<th>Area</th>\n<td>" + @areaValue.to_s  + "</td><td>" +  @unit.to_s + "</td><td>" + @name[1..-2] + "</td>\n<td>" + @description + "</td>\n</tr>"
	end
	
	def to_xml(obj)
		"<Area type=\"#@name\">" + @areaValue.to_s + "</Area>"
	end
	
	def attach_to_obj(obj)
		obj.instance_variable_set("@ext_" + @name[1..-2].uncapitalize.gsub(" ","_"), @areaValue  )
	end
end