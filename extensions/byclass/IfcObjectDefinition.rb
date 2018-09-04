require 'yaml'
class IFCOBJECTDEFINITION
	def hasAssignments	 
	#SET OF IfcRelAssigns FOR RelatedObjects 
		return $hasAssignments[@line_id.to_s].join.toIfcObject.values if $hasAssignments != nil
		cache_file =$cache_folder + "/#$username/#$ifc_file_name/hasAssignments.hash"
		if 	File.exists?(cache_file)
			data=open(cache_file, "rb") {|io| io.read }
			$hasAssignments = Marshal.load(data)
			return $hasAssignments[@line_id.to_s].join.toIfcObject.values
		end
		$hasAssignments={}		
		IFCRELASSIGNS.subclasses.each { |c|
			c.where("all","o").each { |o|
				o.relatedObjects.sub("(","").sub(")","").gsub(",","").split("#").each { |reltedObj|
				$hasAssignments[reltedObj]=[] if $hasAssignments[reltedObj] == nil				 
				if Kernel.const_get("IFCRELASSIGNSTOGROUP") and c == IFCRELASSIGNSTOGROUP
					$hasAssignments[reltedObj] << o.relatingGroup
				elsif Kernel.const_get("IFCRELASSIGNSTOPRODUCT") and c == IFCRELASSIGNSTOPRODUCT	
					$hasAssignments[reltedObj] << o.relatingProduct 
				elsif Kernel.const_get("IFCRELASSIGNSTORESOURCE") and c == IFCRELASSIGNSTORESOURCE				
					$hasAssignments[reltedObj] << o.relatingResource 
				elsif Kernel.const_get("IFCRELASSIGNSTOPROCESS") and c == IFCRELASSIGNSTOPROCESS
					$hasAssignments[reltedObj] << o.relatingProcess 
				elsif Kernel.const_get("IFCRELASSIGNSTOACTOR") and c == IFCRELASSIGNSTOACTOR
					$hasAssignments[reltedObj] << o.relatingActor 
				elsif Kernel.const_get("IFCRELASSIGNSTOCONTROL") and c == IFCRELASSIGNSTOCONTROL
					$hasAssignments[reltedObj] << o.relatingControl
				end
				}		
			}	
		}
		data=Marshal.dump($hasAssignments)
		open(cache_file, 'wb') { |f| f.puts data }		
		$hasAssignments[@line_id.to_s].join.toIfcObject.values
	end
	
	
	def isNestedBy	 #
	#SET OF IfcRelNests FOR RelatingObject;
		return $isNestedBy[@line_id.to_s].join.toIfcObject.values if $isNestedBy != nil
		cache_file =$cache_folder + "/#$username/#$ifc_file_name/isNested.hash"
		if 	File.exists?(cache_file)
			data=open(cache_file, "rb") {|io| io.read }
			$isNestedBy = Marshal.load(data)
			return $isNestedBy[@line_id.to_s].join.toIfcObject.values
		end
		$isNestedBy={}
		IFCRELNESTS.where("all","o").each { |o|
			o.relatedObjects.sub("(","").sub(")","").gsub(",","").split("#").each { |reltedObj|
			$isNestedBy[reltedObj]=[] if $isNestedBy[reltedObj] == nil
			$isNestedBy[reltedObj] << o.relatingObject #.to_obj
			}		
		}		
		data=Marshal.dump($isNestedBy)
		open(cache_file, 'wb') { |f| f.puts data }		
		$isNestedBy[@line_id.to_s].join.toIfcObject.values
	end
	
	def hasContext	 
	#SET [0:1] OF IfcRelDeclares FOR RelatedDefinitions;
		res=[]
		IFCRELDECLARES.where("(o.relatedDefinitions + ',').gsub(' ','').sub(')',',').include?'#" + @line_id.to_s + ",'","o.relatingContext").to_a.join.toIfcObject.each { |k,v|
		res << v
		}
		res
	end
	

	
	def decomposes	 
	#SET [0:1] OF IfcRelAggregates FOR RelatedObjects;	
		res=[]
		IFCRELAGGREGATES.where("o.relatingObject.sub(',','')=='#"+ @line_id.to_s + "'","o.relatedObjects").to_a.join.toIfcObject.each { |k,v|
		res << v
		}
		res
	end
	
	def hasAssociations	 
	#SET OF IfcRelAssociates FOR RelatedObjects;
	#IfcRelAssociatesClassification.RelatingClassification
	#IfcRelAssociatesDocument.RelatingDocument
	#IfcRelAssociatesLibrary.RelatingLibrary
	#IfcRelAssociatesApproval.RelatingApproval 	
	#IfcRelAssociatesMaterial.RelatingMaterial
	#IfcRelAssociatesProfileProperties.RelatingProfileProperties
	#IfcRelAssociatesConstraint.RelatingConstraint
		return $hasAssociations[@line_id.to_s].join.toIfcObject.values if $hasAssociations != nil
		cache_file =$cache_folder + "/#$username/#$ifc_file_name/hasAssociations.hash"
		if 	File.exists?(cache_file)
			data=open(cache_file, "rb") {|io| io.read }
			$hasAssociations = Marshal.load(data)
			return $hasAssociations[@line_id.to_s].join.toIfcObject.values
		end
		$hasAssociations={}		
		IFCRELASSOCIATES.subclasses.each { |c|
			c.where("all","o").each { |o|
				o.relatedObjects.sub("(","").sub(")","").gsub(",","").split("#").each { |reltedObj|
				$hasAssociations[reltedObj]=[] if $hasAssociations[reltedObj] == nil	
				if Kernel.const_get("IfcRelAssociatesMaterial".upcase) and c == IFCRELASSOCIATESMATERIAL
					$hasAssociations[reltedObj] << o.relatingMaterial 				
				elsif Kernel.const_get("IfcRelAssociatesClassification".upcase) and c == IFCRELASSOCIATESCLASSIFICATION
					$hasAssociations[reltedObj] << o.relatingClassification
				elsif Kernel.const_get("IfcRelAssociatesLibrary".upcase) and c == IFCRELASSOCIATESLIBRARY				
					$hasAssociations[reltedObj] << o.relatingLibrary 
				elsif Kernel.const_get("IfcRelAssociatesDocument".upcase) and c == IFCRELASSOCIATESDOCUMENT	
					$hasAssociations[reltedObj] << o.relatingDocument 
				elsif Kernel.const_get("IfcRelAssociatesProfileProperties".upcase) and c == IFCRELASSOCIATESPROFILEPROPERTIES
					$hasAssociations[reltedObj] << o.relatingProfileProperties
				elsif Kernel.const_get("IfcRelAssociatesApproval".upcase) and c == IFCRELASSOCIATESAPPROVAL
					$hasAssociations[reltedObj] << o.relatingProcess
				elsif Kernel.const_get("IfcRelAssociatesConstraint".upcase) and c == IFCRELASSOCIATESCONSTRAINT
					$hasAssociations[reltedObj] << o.relatingConstraint
				end
				}		
			}	
		}
		data=Marshal.dump($hasAssociations)
		open(cache_file, 'wb') { |f| f.puts data }		
		$hasAssociations[@line_id.to_s].join.toIfcObject.values
	end
end
