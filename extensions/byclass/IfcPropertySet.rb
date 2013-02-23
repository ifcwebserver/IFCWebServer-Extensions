class IFCPROPERTYSET	
attr_accessor :html_properties
	def initialize1(args=[])
	@html_properties=property_details
	end
	def property_details
		@hasProperties.to_s.toIfcObject					
		#@property_details_xml=to_details_xml(@hasProperties)
		to_details(@hasProperties.to_s)
		#if $cache_IfcPropertySet_as_HTML 			
		#	if	File.exist?("cache/"  + $username + "/" + $ifc_file_name +  line_id.to_s + ".html") == false 
		#		tmpFile= File.new("cache/"  + $username + "/" + $ifc_file_name +  line_id.to_s + ".html",  "w")
		#		tmpFile.puts "<html>\n<head>\n<link rel=\"stylesheet\" type=\"text/css\" href=\"http://bci52.cib.bau.tu-dresden.de/ifc/style.css\"><body>\n" + @property_details + "\n</body>\n</html>"
		#		tmpFile.close
		#	else
		#		@property_details ="<a href='cache/"  + $username + "/" + $ifc_file_name +  line_id.to_s + ".html' target='_blank'>IFCPROPERTYSET</a>"
		#	end			
		#end
	end	
	
	def properties	
	#doc:<div class='documentaion' >Return an alphabitic sorted array of property names defined insinde the PropertySet object</div>
		res=[]
		@hasProperties.to_s.toIfcObject.each do |k,v| 
		res << v.name
		end
		res.sort
	end
	
	def hasProperty?(property)
	#doc:<div class='documentaion' >Check if the PropertySet has a  single Property with the name 'property', returns false or true</div>
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
	
	def property_details_xml	
		@hasProperties.to_s.toIfcObject
		to_details_xml(@hasProperties.to_s)	
	end
	
	def to_xml(obj=self)
	#(#299,#300,#301,#302,#303,#304,#305,#306,#307,#308,#309)
	@hasProperties.sub("(","").sub("",")").gsub("#","").split(",").each { |p|
	"<property_set_id>"  + obj.line_id.to_s + "</property_set_id><property_id>" + p.to_s + "</property_id>\n"
	}	
	end
	
	def property_names_values
		@hasProperties.to_s.toIfcObject
		names_values(@hasProperties.to_s)			
	end
	
	def PropertyDefinitionOf
	end
	
	def definesType
	end
	
	def attach_to_obj(obj)		
		@hasProperties.to_s.toIfcObject.each { |k,v|
		v.attach_to_obj(obj) if v.respond_to?("attach_to_obj")
		}
	end
end