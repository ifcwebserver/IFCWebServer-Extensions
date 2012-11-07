class IFCCONSTRAINT
	
	#Inverse
	#ab IFC4
	def hasExternalReferences
	end
	
	#Inverse
	#SET OF IfcPropertyConstraintRelationship FOR RelatingConstraint;	
	def propertiesForConstraint
	end	
	
	#Inverse Atts for IFC2X3
	#ClassifiedAs : 	SET OF IfcConstraintClassificationRelationship FOR ClassifiedConstraint;
	#RelatesConstraints: SET OF IfcConstraintRelationship FOR RelatingConstraint;
	#IsRelatedWith : SET OF IfcConstraintRelationship FOR RelatedConstraints;
	#Aggregates : 	SET OF IfcConstraintAggregationRelationship FOR RelatingConstraint;
	#IsAggregatedIn: SET OF IfcConstraintAggregationRelationship FOR RelatedConstraints;
end

