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
	
	#SET [0:?] OF IfcRelConnectsStructuralElement FOR RelatingElement;
	def hasStructuralMember	
	end
	
	def fillsVoids
	#SET [0:1] OF IfcRelFillsElement FOR RelatedBuildingElement;	
	relatingOpeningElementObj=IFCRELFILLSELEMENT.where("o.relatedBuildingElement.to_s=='#" + @line_id.to_s + "'","o.relatingOpeningElement.join").to_obj
	"|" + $ifcClassesNames[relatingOpeningElementObj.class.to_s] + "|" + relatingOpeningElementObj.globalId + "|" + relatingOpeningElementObj.name + "|"	
	end
	
	def connectedTo
	#SET [0:?] OF IfcRelConnectsElements FOR RelatingElement;
		#doc:<div class='documentaion' > return information (class, globalId, name) about the elements which are connected to this element through IfcRelConnectsEelement relationship 
		#doc:</br><a href='ifc.rb?ifc_file=__4D_IFC2x4.ifc&report_cols=name|connectedFrom|connectedTo&q2=IFCBUILDINGELEMENT'>Example</a>: List all connected IfcBuildingElements in the IFC model: __4D_IFC2x4.ifc	</div>
		res= []
		out=IFCRELCONNECTSELEMENTS.where("o.relatingElement.to_s=='#" + @line_id.to_s + "'","o.relatedElement")
		out.join.toIfcObject.each { |k,v| 
			res << v
		}
		res
	end
	
	def hasCoverings
	#SET [0:?] OF IfcRelCoversBldgElements FOR RelatingBuildingElement;
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
	#SET [0:?] OF IfcRelReferencedInSpatialStructure FOR RelatedElements;
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
	
	
	#SET [0:?] OF IfcRelConnectsPortToElement FOR RelatedElement;
	def hasPorts		
	end
	
	def hasOpenings
	#SET [0:?] OF IfcRelVoidsElement FOR RelatingBuildingElement;
		res=[]
		IFCRELVOIDSELEMENT.where("(o.relatingBuildingElement + ',').gsub(' ','').sub(')',',').include?'#" + @line_id.to_s + ",'","o.relatedOpeningElement").to_a.join.toIfcObject.each { |k,v|
		res << v
		}
		res	
	end
	

	def providesBoundaries
	#SET [0:?] OF IfcRelSpaceBoundary FOR RelatedBuildingElement;
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
	#SET [0:?] OF IfcRelConnectsElements FOR RelatedElement;
		#doc:<div class='documentaion' > return information (class, globalId, name) about the elements which are connected with this element through IfcRelConnectsEelement relationship  </div>
		res= ""
		out=IFCRELCONNECTSELEMENTS.where("o.relatedElement.to_s=='#" + @line_id.to_s + "'","o.relatingElement")
		out.join.toIfcObject.each { |k,v| 
			res += "|" + $ifcClassesNames[v.class.to_s] + "|" + v.globalId + "|" + v.name + "|</br>"
		}
		res
	end
	
	def containedInStructure
	#SET [0:1] OF IfcRelContainedInSpatialStructure FOR RelatedElements;
		#doc:<div class='documentaion' > return information (class, globalId, name) of the parent object of this elements </div>
		parentObj=IFCRELCONTAINEDINSPATIALSTRUCTURE.where("o.relatedElements.to_s.include?('#" + @line_id.to_s + "')","o.relatingStructure").to_obj
		"|" + $ifcClassesNames[parentObj.class.to_s] + "|" + parentObj.globalId + "|" + parentObj.name + "|"
	end
	
	["hasOpenings","connectedTo"].each do |name|
    define_method((name + "_html").to_sym) do      
	  HTML.arr_html self.send name.to_sym
    end
	end
	#doc:<b>TODO:</b> hasProjections,isConnectionRealization
end