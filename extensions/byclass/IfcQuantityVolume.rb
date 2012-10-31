class IFCQUANTITYVOLUME 
	def to_row
		"<tr>\n<th>Volume</th>\n<td>" + @volumeValue.to_s + "</td><td>" + @unit.to_s  + "</td>\n<td>" + @name[1..-2] + "</td><td>" + @description + "</td>\n</tr>"
	end
	
	def to_xml(obj)
		"<Volume type=\"#@name\">" + @volumeValue.to_s + "</Volume>"
	end
	
	def attach_to_obj(obj)
		obj.instance_variable_set("@ext_" + @name[1..-2].uncapitalize.gsub(" ","_"), @volumeValue.to_f )
		#puts obj.instance_variable_get(("@" + @name[1..-2].uncapitalize.gsub(" ","_")).to_sym).to_s 		
	end
end