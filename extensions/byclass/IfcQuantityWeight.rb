class IFCQUANTITYWEIGHT
	def to_row		
		unit=""
		unit = @unit.to_obj.name if @unit.to_obj != nil and @unit.to_obj.respond_to?("name")
		"\n\t<tr>\n<td><b>" + @name[1..-2] + "</b></td>\n<td>" + 
		@weightValue.to_s  + "</td><td>" + 
		unit + "</td>\n</tr>"
	end
	
	def to_xml(obj)
		"<WeightValue>" + @weightValue.to_s + "</WeightValue>"
	end
	
	def attach_to_obj(obj)
		obj.instance_variable_set("@ext_" + @name[1..-2].uncapitalize, @weightValue  )
	end
end
