class IFCMAPPEDITEM	
	def area
		@mappingSource.toIfcObject
		$ifcObjects[$ifcObjects[@mappingSource.delete("#").to_i].mappedRepresentation.delete("#").to_i].area.to_f
	end
	
	def volume
		@mappingSource.toIfcObject
		$ifcObjects[$ifcObjects[@mappingSource.delete("#").to_i].mappedRepresentation.delete("#").to_i].volume.to_f
	end
	
	def area_side	
		@mappingSource.toIfcObject
		$ifcObjects[$ifcObjects[@mappingSource.delete("#").to_i].mappedRepresentation.delete("#").to_i].area_side.to_f
	end
	
	def height
		@mappingSource.toIfcObject
		$ifcObjects[$ifcObjects[@mappingSource.delete("#").to_i].mappedRepresentation.delete("#").to_i].height.to_f
	end
	
	def to_dae(objectPlacement=nil)
		@mappingSource.toIfcObject
		mappingSourceObj=$ifcObjects[$ifcObjects[@mappingSource.delete("#").to_i].mappedRepresentation.delete("#").to_i]
		mappedRepresentationObj=$ifcObjects[mappingSourceObj.line_id]
		self.check_transformation		
		items=$ifcObjects[mappedRepresentationObj.line_id].items
		
		Dae.attribute_to_dae(items,objectPlacement)			
	end
	
	def to_dae_geometry(local=nil)	
		@mappingSource.to_s.toIfcObject
		@mappingTarget.to_s.toIfcObject
		$ifcObjects[@mappingSource.delete("#").to_i].mappedRepresentation.to_s.toIfcObject
		mappingSourceObj=$ifcObjects[$ifcObjects[@mappingSource.delete("#").to_i].mappedRepresentation.delete("#").to_i]
		mappedRepresentationObj=$ifcObjects[mappingSourceObj.line_id]
		
		self.check_transformation			
		items=$ifcObjects[mappedRepresentationObj.line_id].items
		
		items.to_s.toIfcObject
		items_list = items.delete("(").delete(")").gsub("#","").split(",")
		items_list.each { |item|
		next if item == ""
		o=$ifcObjects[item.delete("(").delete(")").delete("#").to_i]
		if o == nil
			$log["<br>Line:" + __LINE__.to_s ]= " " + o.class.to_s + "(" + o.line_id.to_s + "): item object is null"
			return ""
		elsif o.respond_to?('to_dae_geometry')
			return o.to_dae_geometry		
		else
			$log["<br>Line:" + __LINE__.to_s ]= " " + o.class.to_s + "(" + o.line_id.to_s + "): to_dae_geometry is not yet supported"
			return ""
		end
		}	
	end	
	
	def to_dae_node(local=nil)
		@mappingSource.toIfcObject
		mappingSourceObj=$ifcObjects[$ifcObjects[@mappingSource.delete("#").to_i].mappedRepresentation.delete("#").to_i]
		mappedRepresentationObj=$ifcObjects[mappingSourceObj.line_id]
		items=$ifcObjects[mappedRepresentationObj.line_id].items
		items_list = items.delete("(").delete(")").gsub("#","").split(",")
		items_list.each { |item|
		next if item == ""
		o=$ifcObjects[item.delete("(").delete(")").delete("#").to_i]
			if o.respond_to?('to_dae_node')
			return o.to_dae_node(local)		
			else
				$log["<br>Line:" + __LINE__.to_s ]= " " + o.class.to_s + "(" + o.line_id.to_s + "): to_dae_node is not yet supported"
				return ""
			end		
		}	
	end
	
	def check_transformation
		@mappingSource.to_s.toIfcObject
		@mappingTarget.to_s.toIfcObject
		mappingSourceObj=$ifcObjects[@mappingSource.delete("#").to_i]
		mappedRepresentation=$ifcObjects[mappingSourceObj.mappedRepresentation.delete("#").to_i]		
		mappingOriginObj=$ifcObjects[mappingSourceObj.mappingOrigin.delete("#").to_i]
		if mappingOriginObj.class.to_s =="IFCAXIS2PLACEMENT3D"
			dx = mappingOriginObj.x
			dy = mappingOriginObj.y
			dz = mappingOriginObj.z
		elsif mappingOriginObj.respond_to?("xy")
			dx,dy=mappingOriginObj.xy
			dz=0
		else
			$log["<br>Line:" + __LINE__.to_s + "_" +line_id.to_s]= "IfcMappedItem:check_transformation..MappingOriginObj:" + mappingOriginObj.class.to_s + " method xy is not yet implemented"
		end				
		mappingTargetObj=$ifcObjects[@mappingTarget.delete("#").to_i]
			axis1 = mappingTargetObj.axis1
			axis2 = mappingTargetObj.axis2
			localOrigin = mappingTargetObj.localOrigin
			scale = mappingTargetObj.scale			
		#26163=IFCCARTESIANTRANSFORMATIONOPERATOR3D($,$,#3,1.,$);
		localOriginObj=$ifcObjects[localOrigin.delete("#").to_i]		
		if axis1.strip != "$"  or axis2.strip != "$" or scale.to_f != 1 #or (localOriginObj.x.to_f * localOriginObj.y.to_f * localOriginObj.z.to_f )!= 0 then
			$log["<br>Line:" + __LINE__.to_s + "_" +line_id.to_s]= "The IfcCartesianTransformationOperator for th IFCMAPPEDITEM:" + line_id.to_s + " object may not be correct applied"
		end		
		#Axis1 	 :  	OPTIONAL IfcDirection;
		#Axis2 	 :  	OPTIONAL IfcDirection;
		#LocalOrigin 	 :  	IfcCartesianPoint;
		#Scale 	 :  	OPTIONAL REAL; 
			#Point(x,y,z) -> LocalOrigin(xo,yo,zo) + Scale * T array * P(x,y,z)
			#Direction --> T * Direction
			#Vector(orientation=d ,magnitude =k) -->  d -> T * d and k -> Scale * k
		#For geometric entities with attributes (such as the radius of a circle) which have the dimensionality of length, the values will be multiplied by S
		#With all optional attributes omitted, the transformation defaults to the identity transformation		
	end	
end