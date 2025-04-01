class IFCMATERIAL
	def attach_to_obj(obj)
	#doc:<div class='documentaion' > This method links the name of the material object to the associated objects through the relation IfcRelAssociatesMaterial as a new attribute .</br> The new attribute to be used in reports or filters called:<ul><li><i>ext_material_name</i></li></ul></div>
		obj.instance_variable_set("@ext_material_name", encode_string(@name)  )
	end
end