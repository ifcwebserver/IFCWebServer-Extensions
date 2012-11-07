class IFCEXTERNALSPATIALELEMENT
	def boundedBy
	#SET OF IfcRelSpaceBoundary FOR RelatingSpace;
		res=[]
		IFCRELSPACEBOUNDARY.where("(o.relatingSpace + ',').gsub(' ','').sub(')',',').include?'#" + @line_id.to_s + ",'","o.relatedBuildingElement").to_a.join.toIfcObject.each { |k,v|
		res << v
		}
		res
	end
end