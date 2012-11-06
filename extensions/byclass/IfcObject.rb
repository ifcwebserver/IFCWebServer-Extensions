class IFCOBJECT
	def isDefinedBy
	 #SET OF IfcRelDefines FOR RelatedObjects;
	end
	
	def isDeclaredBy
	#SET [0:1] OF IfcRelDefinesByObject FOR RelatedObjects;
	end
	def declares	 
	#SET OF IfcRelDefinesByObject FOR RelatingObject;
	end
	
	def isTypedBy	 
	#SET [0:1] OF IfcRelDefinesByType FOR RelatedObjects;
	end
end