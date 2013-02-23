class IFCRELDEFINESBYPROPERTIES	
	def initialize1(args=[])			
		@relatedObjects.to_s.toIfcObject.each {|k,v|		
		relatingP_Obl = @relatingPropertyDefinition.to_s.to_obj
		relatingP_Obl.attach_to_obj(v)	if relatingP_Obl.respond_to?("attach_to_obj")		
		}	
	$depend_on={} if $depend_on == nil
    $depend_on[@relatedObjects.to_s] ="" if $depend_on[@relatedObjects.to_s]== nil
    $depend_on[@relatedObjects.to_s] += "#" + @line_id.to_s
	end
	
	def to_xml(obj=self)
	#311=IFCRELDEFINESBYPROPERTIES('2wMN$cKQ90ZhF$zxDb72Bi',#6,$,$,(RelatedObjects, , , ,),RelatingPropertyDefinition);
	@relatedObjects.sub("(","").sub("",")").gsub("#","").split(",").each { |o|
	"<ifc_object_id>" + o.to_s + "</ifc_object_id><property_set_id>"  + @relatingPropertyDefinition.sub("#","") + "</property_set_id>\n"
	}	
	end
end


