class IFCMATERIALLIST
	def getMaterials
		res=""
		@materials.to_s.toIfcObject
		@materials.sub("(","").sub(")","").gsub(",","").split("#").each { |id|
		next if id == ""
		res += $ifcObjects[id.to_i].name + "</br>"
		}
		return res[0..-6]		
	end
	
	def attach_to_obj(obj)
		#doc:<div class='documentaion' > This method links the names and count of the material objects which are associated to objects through the relation IfcRelAssociatesMaterial as a new attributes .</br> The new attributes to be used in reports or filters called:<ul><li><i>ext_materiallist_name</i></li><li><i>ext_materiallist_count</i></li></ul></div>
		res = "|"
		count = 0
		@materials.to_s.toIfcObject.each { |k,v|
		res += fix_it(v.name) + "|"
		count += 1
		}
		obj.instance_variable_set("@ext_materiallist_name", res )		
		obj.instance_variable_set("@ext_materiallist_count", count)				
	end
end

