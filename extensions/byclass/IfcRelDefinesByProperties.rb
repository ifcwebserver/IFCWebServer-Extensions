class IFCRELDEFINESBYPROPERTIES	
	def initialize1(args=[])			
		attach if $loading_relation
		cache #if $depend_on[@relatedObjects.to_s.gsub("(","").gsub(")","")]== nil 
	end
	
	def to_xml(obj=self)
	@relatedObjects.sub("(","").sub("",")").gsub("#","").split(",").each { |o|
	"<ifc_object_id>" + o.to_s + "</ifc_object_id><property_set_id>"  + @relatingPropertyDefinition.sub("#","") + "</property_set_id>\n"
	}	
	end
	
	def cache
	$depend_on={} if $depend_on == nil
	$psets={} if $psets == nil
    $depend_on[@relatedObjects.to_s.gsub("(","").sub(")","")] = "" if $depend_on[@relatedObjects.to_s.gsub("(","").gsub(")","")]== nil
    $depend_on[@relatedObjects.to_s.gsub("(","").sub(")","")] += "#" + @line_id.to_s
	@relatedObjects.to_s.gsub(",","").sub("(","").sub(")","").split("#").each { |relObj|
	next if relObj == "" or relatingPropertyDefinition.to_s == ""
	 $psets[relObj] = [] if  $psets[relObj] == nil
	 $psets[relObj] << relatingPropertyDefinition
	}	
	end
	
	def attach
	 @relatedObjects.to_s.toIfcObject.each {|k,v|		
		relatingP_Obl = @relatingPropertyDefinition.to_s.to_obj
		relatingP_Obl.attach_to_obj(v)	if relatingP_Obl.respond_to?("attach_to_obj")		
		}	
	end	
end


