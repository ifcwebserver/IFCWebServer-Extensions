class IFCQUANTITYTIME
	def to_row		
		"<tr>\n<th>Length</th>\n<td>" + @timeValue.to_s  + "</td><td>" +  @unit.to_s + "</td><td>" + @name[1..-2] + "</td>\n<td>" + @description + "</td>\n</tr>"
	end
	
	def to_xml(obj)
		"<TimeValue>" + @timeValue.to_s + "</TimeValue>"
	end
	
	def attach_to_obj(obj)
		obj.instance_variable_set("@ext_" + @name[1..-2].uncapitalize.gsub(" ","_"), @timeValue  )
	end
end