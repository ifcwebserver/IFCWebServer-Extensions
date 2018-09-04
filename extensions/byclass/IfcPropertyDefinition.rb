require 'htmlentities'
class IFCPROPERTYDEFINITION
	def to_details(str="")	
		return if @name == nil
		res = ""  		
		res = res + "<table width='100%' class='propertyset'>"
		res = res + "<tr><th colspan=2>" + encode_string(@name.strip[1..-2]) + "</td></tr>" if @name != "$"		
		str.toIfcObject.each { |k,obj|				
			if ($include_properties.size == 0 or $include_properties.include? fix_it(obj.name)) and not $ignore_properties.include? fix_it(obj.name)
				res = res +  obj.to_row	if obj.respond_to?("to_row")
			end		
		}
		res = res + "</table>"
		return res	
	end
	
	def to_details_xml(str="")			
		return if @name == nil	
		res = "" 		
		str.toIfcObject.each { |k,obj|								
			if ($include_properties.size == 0 or $include_properties.include? fix_it(obj.name)) and not $ignore_properties.include? fix_it(obj.name)
				res = res +  obj.to_xml	if obj.respond_to?("to_xml")
			end
		}		
		return res			
	end
	
	def property_names_values
		@hasProperties.to_s.toIfcObject
		names_values(@hasProperties.to_s)			
	end
	
	def valid_name(obj=self)
		attName=fix_it(obj.name).gsub("'","").gsub(" ","_").gsub("-","_").gsub(".","_").gsub("/","_")
		attName = attName.gsub("__","_")
		attName = attName.gsub("__","_")
		attName = attName.gsub("/","_")
		attName = attName.gsub("(","_")
		attName = attName.gsub(")","_")
		attName = attName.gsub(".","")
		attName = attName.gsub("[","_")
		attName = attName.gsub("]","_")
	end
	
	def names_values(str="")
	  return if @name == nil	
		res_names = []
		res_values = []
		str.toIfcObject.each { |k,obj|	
		next if obj.class == IFCCOMPLEXPROPERTY
		if ($include_properties.size == 0 or $include_properties.include? fix_it(obj.name)) and not $ignore_properties.include? fix_it(obj.name)
			if obj.respond_to?("valid_name")
				att_name= "'" + obj.valid_name.gsub(",","") + "'"
			else
				att_name=  "'" + valid_name(obj).gsub(",","") + "'"	if obj.respond_to?("name")
			end
			if obj.respond_to?("valid_value")
				att_value= "'" + obj.valid_value.gsub(",","")	+ "'" 
			else
				att_value= "'" + obj.value.to_s.gsub("'","").gsub(",","")	+ "'" if obj.respond_to?("value")			
			end
			next if ["MODEL","OBJECTCLASS","STEP_ID","GUID","NAME","TAG","DESCRIPTION","OBJECTTYPE","PARENT","MATERIAL","MATERIALS"].include?(att_name.upcase.gsub("'",""))		
			next if res_names.include?(att_name)
			res_names <<   att_name
			res_values <<  att_value
			$att_max_size[att_name] = att_value.size if $att_max_size[att_name] == nil or att_value.size > $att_max_size[att_name]			
		end
		}		
		res={}
		res['names']  = res_names.join(",") 
		res['values'] = res_values.join(",")			
		return res		
	end
	
	def names_values_hash(str="")
	  return if @name == nil	
		res={}
		str.toIfcObject.each { |k,obj|	
		next if obj.class == IFCCOMPLEXPROPERTY
		att_name= nil
		att_value = nil		
		if obj.class == IFCPROPERTYSINGLEVALUE	
			att_name=   encode_string(obj.name.to_s )
			att_value = obj.nominalValue.to_s.sub("IFCTHERMALTRANSMITTANCEMEASURE(","").sub("IFCAREAMEASURE(","").sub("IFCTEXT(","").sub("IFCBOOLEAN(","").sub("IFCIDENTIFIER(","").sub("IFCINTEGER(","").sub("IFCLABEL(","").sub("IFCLENGTHMEASURE(","").sub("IFCPLANEANGLEMEASURE(","").sub("IFCPOSITIVELENGTHMEASURE(","").sub("IFCREAL(","").sub("IFCVOLUMEMEASURE(","").sub(")","")	
			att_value= encode_string(att_value)
		#elsif 	obj.class == IFCPROPERTYENUMERATEDVALUE TODO
		#elsif 	obj.class == IFCPROPERTYBOUNDEDVALUE TODO
		#elsif 	obj.class == IFCPROPERTYTABLEVALUE TODO
		#elsif 	obj.class == IFCPROPERTYREFERENCEVALUE TODO
		#elsif 	obj.class == IFCPROPERTYLISTVALUE TODO
		end
		res[att_name]=att_value if att_name and att_value
		}		
		return res		
	end
	
end