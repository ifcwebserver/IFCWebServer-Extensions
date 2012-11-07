class IFCCLASSIFICATION
	#IFC2x4 CHANGE  New inverse attribute.
	#SET OF IfcRelAssociatesClassification FOR RelatingClassification;
	def classificationForObjects
	end
	
	#ab IFC4X???
	#SET OF IfcClassificationReference FOR ReferencedSource;
	def hasReferences
	end  
	
	#for IFC2X3
	#SET OF IfcClassificationItem FOR ItemOf;
	def contains	
	end
end