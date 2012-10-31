class IFCQUANTITYWEIGHT
	def to_row		
		"<tr>\n<th>Length</th>\n<td>" + @weightValue.to_s  + "</td><td>" +  @unit.to_s + "</td><td>" + @name[1..-2] + "</td>\n<td>" + @description + "</td>\n</tr>"
	end
	
	def to_xml(obj)
		"<WeightValue>" + @weightValue.to_s + "</WeightValue>"
	end
	
	def attach_to_obj(obj)
		obj.instance_variable_set("@ext_" + @name[1..-2].uncapitalize, @weightValue  )
	end
end
