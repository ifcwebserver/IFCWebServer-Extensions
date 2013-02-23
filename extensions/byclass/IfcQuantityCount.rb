class IFCQUANTITYCOUNT
	def to_row		
		unit=""
		unit = @unit.to_obj.name if @unit.to_obj != nil and @unit.to_obj.respond_to?("name")
		"<tr>\n<th>" + @name[1..-2] + " </th>\n<td>" + 
		@countValue.to_s  + "</td><td>" + 
		unit + "</td>\n</tr>"
	end
	
	def to_xml(obj)
		"<CountValue>" + @countValue.to_s + "</CountValue>"
	end
	
	def attach_to_obj(obj)
		obj.instance_variable_set("@ext_" + @name[1..-2].uncapitalize.gsub(" ","_"), @countValue  )
	end
end