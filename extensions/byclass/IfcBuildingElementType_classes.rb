class IFCDOORSTYLE
	def attach_to_obj(obj)
		super
		obj.instance_variable_set("@ext_Type_OperationType", @operationType)
		obj.instance_variable_set("@ext_Type_ConstructionType", @constructionType)
		obj.instance_variable_set("@ext_Type_ParameterTakesPrecedence", @parameterTakesPrecedence.sub(".T.","true").sub(".F.","false"))
		obj.instance_variable_set("@ext_Type_Sizeable", @sizeable.sub(".T.","true").sub(".F.","false"))	
	end
end	

class IFCWINDOWSTYLE
	def attach_to_obj(obj)
		super
		obj.instance_variable_set("@ext_Type_OperationType", @operationType)
		obj.instance_variable_set("@ext_Type_ConstructionType", @constructionType)
		obj.instance_variable_set("@ext_Type_ParameterTakesPrecedence", @parameterTakesPrecedence.sub(".T.","true").sub(".F.","false"))
		obj.instance_variable_set("@ext_Type_Sizeable", @sizeable.sub(".T.","true").sub(".F.","false"))	
	end
end	


class IFCCOVERINGTYPE
end

class IFCBEAMTYPE
end

class IFCMEMBERTYPE
end

class IFCCOLUMNTYPE
end 

class IFCWALLTYPE
end 

class IFCSLABTYPE
end 

class IFCSTAIRFLIGHTTYPE
end

class IFCRAMPFLIGHTTYPE
end

class IFCCURTAINWALLTYPE
end

class IFCRAILINGTYPE
end

class IFCBUILDINGELEMENTPROXYTYPE
end

class IFCPLATETYPE
end

class IFCFURNITURETYPE
# AssemblyPlace
end
