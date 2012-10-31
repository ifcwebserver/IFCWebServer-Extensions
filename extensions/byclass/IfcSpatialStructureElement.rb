class IFCSPATIALSTRUCTUREELEMENT
	def containsElements
		#TODO: grouping the relatedElements according to their types
		res= ""
		out = IFC.where(IFCRELCONTAINEDINSPATIALSTRUCTURE,"o.relatingStructure.to_s=='#" + @line_id.to_s + "'","o.relatedElements")
		out.toIfcObject.each { |k,v| 
		res += $ifcClassesNames[v.class.to_s] + "(" + v.globalId + "): " + v.name + "</br>"
		}
		res
	end
end