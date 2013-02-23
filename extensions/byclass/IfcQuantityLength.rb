class IFCQUANTITYLENGTH
	def to_row
		unit=""
		unit = @unit.to_obj.name if @unit.to_obj != nil and @unit.to_obj.respond_to?("name")
		"<tr>\n<th>" + @name[1..-2] + " </th>\n<td>" + 
		@lengthValue.to_s  + "</td><td>" + 
		unit + "</td>\n</tr>"
	end
	
	def to_xml(obj)
		"<Length type=\"#@name\">" + @lengthValue.to_s + "</Length>"
	end
	
	def attach_to_obj(obj)
		obj.instance_variable_set("@ext_" + @name[1..-2].uncapitalize.gsub(" ","_"), @lengthValue  )
	end
end