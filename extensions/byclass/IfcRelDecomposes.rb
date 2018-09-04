class  IFCRELDECOMPOSES
	def initialize1(args=[])			
		attach_to_obj #if $loading_relation == true
		super
	end
	
	
	def attach_to_obj
		@relatedObjects.to_s.toIfcObject.each {|k,v|		
		relatingObject_Obj = @relatingObject.to_s.to_obj	
		isDecomposedBy= {}
		isDecomposedBy['globalId'] =relatingObject_Obj.globalId
		isDecomposedBy['line_id'] = "#" + relatingObject_Obj.line_id.to_s
		isDecomposedBy['name'] =relatingObject_Obj.name
		isDecomposedBy['class'] =relatingObject_Obj.class.to_s		
		v.instance_variable_set("@isDecomposedBy" , isDecomposedBy )	if relatingObject_Obj != nil
		v.instance_variable_set("@isDecomposedBy_RelatingObject" , relatingObject_Obj.name )	if relatingObject_Obj != nil		
		}	
	end
end

