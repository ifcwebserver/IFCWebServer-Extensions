class IFCSPATIALSTRUCTUREELEMENT
	def containsElements
		#TODO: grouping the relatedElements according to their types
		res= ""
		out = IFCRELCONTAINEDINSPATIALSTRUCTURE.where("o.relatingStructure.to_s=='#" + self.line_id.to_s + "'","o.relatedElements")
		out.to_s.toIfcObject.each { |k,v| 
		res += $ifcClassesNames[v.class.to_s] + "(" + v.globalId + "): " + v.name + "</br>"
		}
		res
	end
	
	def containsElements_count
		#TODO: grouping the relatedElements according to their types
		res= ""
		out = IFCRELCONTAINEDINSPATIALSTRUCTURE.where("o.relatingStructure.to_s=='#" + self.line_id.to_s + "'","o.relatedElements")
		obj_per_class={}
		out.to_s.toIfcObject.each { |k,v| 
		obj_per_class[$ifcClassesNames[v.class.to_s]] = 0 if obj_per_class[$ifcClassesNames[v.class.to_s]] == nil
		obj_per_class[$ifcClassesNames[v.class.to_s]] +=1
		}
		obj_per_class
		res={}
		res["class"]= $ifcClassesNames[self.class.to_s]
		res["STEPID"]= self.line_id
		res["name"]= self.fix_it(self.name)
		res["GUID"]= self.globalId
		res["containsElements"] = obj_per_class
		res
	end
	
	
end