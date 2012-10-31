class IFCTYPEPRODUCT
	def attach_to_obj(obj)
	#doc:<div class='documentaion' >
	#doc:This method links the "Type" properties with the associated objects(through <b>IfcRelDefinesByType</b>) as new attributes to be used in reports and quires as fellow:
	#doc:<ul><li>IfcTypeProduct</li><ul><li>ext_Type_Name</li><li>ext_Type_Description</li><li>ext_Type_ApplicableOccurrence</li><li>ext_Type_HasPropertySets</li><li>ext_Type_RepresentationMaps</li><li>ext_Type_Tag</li><ul>IfcElementType<li>ext_Type_ElementType</li><ul>IfcBuildingElementType<li>ext_Type_PredefinedType</li></ul></ul></ul>
	#doc:<ul>IfcDoorStyle and IfcWindowStyle<li>ext_Type_OperationType</li><li>ext_Type_ConstructionType</li><li>ext_Type_ParameterTakesPrecedence</li><li>ext_Type_Sizeable</li></ul>
	#doc:</div>	
		obj.instance_variable_set("@ext_Type_Name", @name)									if @name != "$"
		obj.instance_variable_set("@ext_Type_Description", @description) 					if @description != "$"
		obj.instance_variable_set("@ext_Type_ApplicableOccurrence", @applicableOccurrence) 					if @applicableOccurrence != "$"		
		obj.instance_variable_set("@ext_Type_HasPropertySets", @hasPropertySets)			if @hasPropertySets != "$"		
		@hasPropertySets.to_s.toIfcObject.each { |k,v|		
		v.attach_to_obj(obj) if v.respond_to?("attach_to_obj")		
		}
		obj.instance_variable_set("@ext_Type_RepresentationMaps", @representationMaps)		if @representationMaps != "$"			
		obj.instance_variable_set("@ext_Type_Tag", @tag)  									if @tag != "$"			
		obj.instance_variable_set("@ext_Type_ElementType", @elementType) 					if @elementType != "$"
		obj.instance_variable_set("@ext_Type_PredefinedType", @predefinedType)				if @predefinedType != nil and @predefinedType != "$"
	end
end