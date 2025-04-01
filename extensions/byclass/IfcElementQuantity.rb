class IFCELEMENTQUANTITY
	def to_details(str="")	
		return if @name == nil
		res = ""  
		#res = res + "<br><b>Description:</b>" + @description + "<br>" if @description != "$"
		#res = res +"<b>GlobalId:</b>" + @globalId 	+ "<br>"	
		#res = res +"<b>IFC_LineID:</b>" + @line_id.to_s 		
		res = res + "<table width='100%' class='propertyset'>"
		res = res + "\n\t<tr>\n\t<th colspan=3>" + @name.strip[1..-2] + "</th></tr>" if @name != "$"
		str.toIfcObject.each { |k,obj|
			res = res +  obj.to_row	
		}
		res = res + "\n</table>"
		return res	
	end
	
	def property_names_values_hash		
		names_values_hash(@quantities.to_s)			
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
	
	def names_values_hash(str="")	
		res={}
		str.toIfcObject.each { |k,obj|	
		next if obj.class == IFCCOMPLEXPROPERTY
		att_name= nil
		att_value = nil	
		att_name=   encode_string(obj.name.to_s )		
		if obj.class == IFCQUANTITYLENGTH
			att_value = obj.lengthValue.to_s			
		elsif 	obj.class == IFCQUANTITYAREA 
			att_value = obj.areaValue.to_s
		elsif 	obj.class == IFCQUANTITYVOLUME 
			att_value = obj.volumeValue.to_s
		elsif 	obj.class == IFCQUANTITYCOUNT
			att_value = obj.countValue.to_s		
		elsif 	obj.class == IFCQUANTITYWEIGHT
			att_value = obj.weightValue.to_s		
		elsif 	obj.class == IFCQUANTITYTIME
			att_value = obj.timeValue.to_s
		end
		att_value += "|" + obj.unit if obj.unit != '$'
		res[att_name]=att_value if att_name and att_value
		}		
		return res		
	end	
end