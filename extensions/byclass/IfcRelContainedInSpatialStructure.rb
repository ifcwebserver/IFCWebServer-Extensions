class IFCRELCONTAINEDINSPATIALSTRUCTURE
	def initialize1(args=[])			
		attach_to_obj if $loading_relation == true
	end
	
	def attach_to_obj
		@relatedElements.to_s.toIfcObject.each {|k,v|		
		relatingStructure_Obj = @relatingStructure.to_s.to_obj	
		containedInStructure= {}
		containedInStructure['globalId'] =relatingStructure_Obj.globalId
		containedInStructure['name'] =relatingStructure_Obj.name
		containedInStructure['class'] =relatingStructure_Obj.class.to_s		
		v.instance_variable_set("@containedInStructure" , containedInStructure )	if relatingStructure_Obj != nil		 
		#v.instance_variable_set("@containedInStructure" , relatingStructure_Obj.globalId  )	if relatingStructure_Obj != nil		 
		#v.instance_variable_set("@containedInStructureName" , relatingStructure_Obj.name  )	if relatingStructure_Obj != nil		 
		#v.instance_variable_set("@containedInStructureClass" , $ifcClassesNames[relatingStructure_Obj.class.to_s]  )	if relatingStructure_Obj != nil		 
		}	
	end
end