class IFCRELDEFINESBYTYPE
	def initialize1(args=[])			
		attach_to_obj
	end
	
	def attach_to_obj
		@relatedObjects.to_s.toIfcObject.each {|k,v|		
		relatingTypeObj = @relatingType.to_s.to_obj
		relatingTypeObj.attach_to_obj(v)	if relatingTypeObj.respond_to?("attach_to_obj")		
		}	
	end
end 