class IFCQUANTITYLENGTH
	def to_row
		"<tr>\n<th>Length</th>\n<td>" + @lengthValue.to_s  + "</td><td>" +  @unit.to_s + "</td><td>" + @name[1..-2] + "</td>\n<td>" + @description + "</td>\n</tr>"
	end
	
	def to_xml(obj)
		"<Length type=\"#@name\">" + @lengthValue.to_s + "</Length>"
	end
	
	def attach_to_obj(obj)
		obj.instance_variable_set("@ext_" + @name[1..-2].uncapitalize.gsub(" ","_"), @lengthValue  )
	end
end