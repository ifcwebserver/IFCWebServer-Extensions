class IFCOBJECT
	
	#SET OF IfcRelDefines FOR RelatedObjects;
	def isDefinedBy	
	end
	
	#SET [0:1] OF IfcRelDefinesByObject FOR RelatedObjects;
	def isDeclaredBy	
	end
	
	#SET OF IfcRelDefinesByObject FOR RelatingObject;
	def declares	
	end
	
	#SET [0:1] OF IfcRelDefinesByType FOR RelatedObjects;
	def isTypedBy	
	end
end