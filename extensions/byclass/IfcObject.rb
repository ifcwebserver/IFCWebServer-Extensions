class IFCOBJECT	
	#SET OF IfcRelDefines FOR RelatedObjects;
	def isDefinedBy
		res= ""
		out=IFCRELDEFINESBYPROPERTIES.where("o.relatedObjects.to_s.include?('#" + @line_id.to_s + "')","o.relatingPropertyDefinition")
		out.join.toIfcObject.each { |k,v| 			
			if v.respond_to?('property_details')
				res += v.property_details
			else
				res += "|" + $ifcClassesNames[v.class.to_s] + "|" + v.globalId + "|" + v.name + "|</br>"
			end
		}		
		out=IFCRELDEFINESBYTYPE.where("o.relatedObjects.to_s.include?('#" + @line_id.to_s + "')","o.relatingType")
		out.join.toIfcObject.each { |k,v| 
			if v.respond_to?('property_details')
				res += v.property_details 			
			else
				res += "|" + $ifcClassesNames[v.class.to_s] + "|" + v.globalId + "|" + v.name + "|</br>"
			end			
		}		
		res
	end	
	
	#SET [0:1] OF IfcRelDefinesByObject FOR RelatedObjects;
	def isDeclaredBy	
	end
	
	#SET OF IfcRelDefinesByObject FOR RelatingObject;
	def declares	
	end
	
	#SET [0:1] OF IfcRelDefinesByType FOR RelatedObjects;
	def isTypedBy	
	end
end