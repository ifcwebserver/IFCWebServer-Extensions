class IFCELEMENT
	def initialize1(args=[])

	end
	def get_inverse_attributes
	
	end

	def isDefinedBy
		res= ""
		out=IFCRELDEFINESBYPROPERTIES.where("o.relatedObjects.to_s.include?('#" + @line_id.to_s + "')","o.relatingPropertyDefinition")
		out.join.toIfcObject.each { |k,v| 			
			if v.respond_to?('property_details')
				res += v.property_details
			else
				res += "|" + $ifcClassesNames[v.class.to_s] + "|" + v.globalId + "|" + v.name + "|</br>"
			end
		}		
		out=IFCRELDEFINESBYTYPE.where("o.relatedObjects.to_s.include?('#" + @line_id.to_s + "')","o.relatingType")
		out.join.toIfcObject.each { |k,v| 
			if v.respond_to?('property_details')
				res += v.property_details 			
			else
				res += "|" + $ifcClassesNames[v.class.to_s] + "|" + v.globalId + "|" + v.name + "|</br>"
			end			
		}		
		res
	end
	 
	 
	def referencedBy
	
	end
	
	def hasStructuralMember
	
	end
	
	def fillsVoids	
	relatingOpeningElementObj=IFCRELFILLSELEMENT.where("o.relatedBuildingElement.to_s=='#" + @line_id.to_s + "'","o.relatingOpeningElement.join").to_obj
	"|" + $ifcClassesNames[relatingOpeningElementObj.class.to_s] + "|" + relatingOpeningElementObj.globalId + "|" + relatingOpeningElementObj.name + "|"	
	end
	
	def connectedTo
		#doc:<div class='documentaion' > return information (class, globalId, name) about the elements which are connected to this element through IfcRelConnectsEelement relationship 
		#doc:</br><a href='ifc.rb?ifc_file=__4D_IFC2x4.ifc&report_cols=name|connectedFrom|connectedTo&q2=IFCBUILDINGELEMENT'>Example</a>: List all connected IfcBuildingElements in the IFC model: __4D_IFC2x4.ifc	</div>
		res= ""
		out=IFCRELCONNECTSELEMENTS.where("o.relatingElement.to_s=='#" + @line_id.to_s + "'","o.relatedElement")
		out.join.toIfcObject.each { |k,v| 
			res += "|" + $ifcClassesNames[v.class.to_s] + "|" + v.globalId + "|" + v.name + "|</br>"
		}
		res
	end
	
	def hasCoverings
		res= "<table width='100%'><tr><th>Covering ID</th><th>Opening name</th><th>Description</th></tr>"
		out=IFCRELCOVERSBLDGELEMENTS.where("o.relatingBuildingElement.to_s=='#" + @line_id.to_s + "'","o.relatedCoverings")	
		out.join.toIfcObject.each { |k,v| 
				res += "<tr><td>" +  v.globalId + "</td><td>" + v.name + "</td><td>" + v.description + "</td></tr>"
			}
		res += "</table>"
		return res if out != ""
		""		
	end

	def referencedInStructures
	#doc:<div class='documentaion' >List the spatial structure elements(site, building, buildingStorey, space) in which this IfcElement object is referenced (through IfcRelReferencedInSpatialStructure), but not primarily contained</div>
	res= "<table width='100%'><tr><th>RelatingStructure class</th><th>globalId</th><th>Name</th></tr>"
		out=IFCRELREFERENCEDINSPATIALSTRUCTURE.where("o.relatedElements.to_s.include?('#" + @line_id.to_s + "')","o.relatingStructure")
		out.join.toIfcObject.each { |k,v| 
			res += "<tr><td>" + $ifcClassesNames[v.class.to_s] + "</td><td>" + v.globalId + "</td><td>" + v.name + "</td><td></tr>"
		}
		res += "</table>"
		return res if out != ""
		""	
	end
	
	def hasOpenings
		res= "<table width='100%'><tr><th>Opening ID</th><th>Opening name</th><th>Description</th></tr>"
		out=IFCRELVOIDSELEMENT.where("o.relatingBuildingElement.to_s=='#" + @line_id.to_s + "'","o.relatedOpeningElement")
		out.join.toIfcObject.each { |k,v| 
			res += "<tr><td>" + v.globalId + "</td><td>" + v.name + "</td><td>" + v.description + "</td><td></tr>"
		}
		res += "</table>"
		return res if out != ""
		""	
	end
	
	def providesBoundaries
		#doc:<div class='documentaion' > return a table of spaces objects of space boundaries which are defined through IfcRelSpaceBoundary relation for this IfcElement instance</br>
		#doc:<a href='ifc.rb?ifc_file=AC10-Institute-Var-1.ifc&report_cols=name|globalId|providesBoundaries&output_format=to_html&q1=IFCSLAB&q2=IFCWALLIFCWALLSTANDARDCASE'>Example</a>: List space boundaries of slabs and walls in the IFC model :AC10-Institute-Var-1.ifc </div> 
		res= "<table width='100%'><tr><th>Space id</th><th>Space name</th></tr>"
		out=IFCRELSPACEBOUNDARY.where("o.relatedBuildingElement.to_s=='#" + @line_id.to_s + "'","o.relatingSpace")		
		out.join.toIfcObject.each { |k,v| 
			res += "<tr><td>" +  v.globalId + "</td><td>" + v.name + "</td></tr>"
		}
		res += "</table>"
		return res if out != ""
		""	
	end
	
	def connectedFrom
		#doc:<div class='documentaion' > return information (class, globalId, name) about the elements which are connected with this element through IfcRelConnectsEelement relationship  </div>
		res= ""
		out=IFCRELCONNECTSELEMENTS.where("o.relatedElement.to_s=='#" + @line_id.to_s + "'","o.relatingElement")
		out.join.toIfcObject.each { |k,v| 
			res += "|" + $ifcClassesNames[v.class.to_s] + "|" + v.globalId + "|" + v.name + "|</br>"
		}
		res
	end
	
	def containedInStructure
		#doc:<div class='documentaion' > return information (class, globalId, name) of the parent object of this elements </div>
		parentObj=IFCRELCONTAINEDINSPATIALSTRUCTURE.where("o.relatedElements.to_s.include?('#" + @line_id.to_s + "')","o.relatingStructure").to_obj
		"|" + $ifcClassesNames[parentObj.class.to_s] + "|" + parentObj.globalId + "|" + parentObj.name + "|"
	end
	
	#doc:<b>TODO:</b> hasProjections, hasPorts, isConnectionRealization

end