class IFCPROPERTYSET	
attr_accessor :html_properties
	def initialize1(args=[])
	  @html_properties=property_details
	  
	end
	def property_details
		@hasProperties.to_s.toIfcObject					
		to_details(@hasProperties.to_s)
	end	
	
	def properties	
	#doc:<div class='documentaion' >Return an alphabitic sorted array of property names defined insinde the PropertySet object</div>
		res=[]
		@hasProperties.to_s.toIfcObject.each do |k,v| 
		res << v.name.gsub("'","")
		end
		res.sort
	end
	
	def hasProperty?(property)
	#doc:<div class='documentaion' >Check if the PropertySet has a  single Property with the name 'property', returns false or true</div>
		res={}
		@hasProperties.to_s.toIfcObject.each do |k,v| 
		res << v.name.gsub("'","")
		end
		res.sort
		properties.include?(pro)
	end
	
	def hasPropertyWithValue?(property,val)
	#doc:<div class='documentaion' >Check if the PropertySet has a single Property with the name 'property' and the value 'value', returns false or true</div>
		@hasProperties.to_s.toIfcObject.each do |k,v| 
			if  fix_it(v.name) == property
			return true if v.class == IFCPROPERTYSINGLEVALUE and fix_it(v.nominalValue) == val
			end
		end
		false
	end

       def property_value(name="")	
		res=""
		@hasProperties.to_s.toIfcObject.each do |k,v| 
		return v.valid_value if v.name.gsub("'","") == name
		end
		res
	end
	
	def property_details_xml	
		@hasProperties.to_s.toIfcObject
		to_details_xml(@hasProperties.to_s)	
	end
	
	def to_xml(obj=self)
	@hasProperties.sub("(","").sub("",")").gsub("#","").split(",").each { |p|
	"<property_set_id>"  + obj.line_id.to_s + "</property_set_id><property_id>" + p.to_s + "</property_id>\n"
	}	
	end
	
	def property_names_values
		@hasProperties.to_s.toIfcObject
		names_values(@hasProperties.to_s)			
	end	
	
	def property_names_values_hash
		@hasProperties.to_s.toIfcObject
		names_values_hash(@hasProperties.to_s)			
	end	
	
	def attach_to_obj(obj)		
		@hasProperties.to_s.toIfcObject.each { |k,v|
		v.attach_to_obj(obj) if v.respond_to?("attach_to_obj")
		}
	end
end