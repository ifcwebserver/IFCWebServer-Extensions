class IFCELEMENTQUANTITY
	def to_details(str="")	
		return if @name == nil
		res = ""  
		#res = res + "<br><b>Description:</b>" + @description + "<br>" if @description != "$"
		#res = res +"<b>GlobalId:</b>" + @globalId 	+ "<br>"	
		#res = res +"<b>IFC_LineID:</b>" + @line_id.to_s 		
		res = res + "<table width='100%' class='propertyset'>\n"
		res = res + "<tr><th colspan=5>" + @name.strip[1..-2] + "</th></tr>" if @name != "$"
		res = res + "<tr><th></th><th>Value</th><th>Unit</th><th>Name</th><th>Description</th></tr>"
		str.sub!("#","").sub!("(","").sub!(")","").split("#").each { |o|
		if o != nil
			o=o.to_s.strip.to_i
			obj=$ifcObjects[o]			
			if obj != nil
				res = res +  obj.to_row	
			else			
			LineDataParser.load_one_object("#" + o.to_s,false)	
			obj=$ifcObjects[o]
			res = res +  obj.to_row	
			end
		end
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