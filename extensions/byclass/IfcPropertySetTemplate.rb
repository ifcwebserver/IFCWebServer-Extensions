class IFCPROPERTYSETTEMPLATE 
	 def propertyTemplates_html
		res= []
		hasPropertyTemplates.toIfcObject.each { |k,o|
		row ="<tr><td>" + o.name.to_s.gsub("'","") + "</td>"
		primaryMeasureType=""
		primaryMeasureType = o.primaryMeasureType.to_s.gsub("'","") if o.respond_to?("primaryMeasureType") and o.primaryMeasureType != nil
		row += "<td>" + primaryMeasureType.to_s + "</td></tr>"
		res << row
		}
		"<table><tr><th>Name</th><th>PrimaryMeasureType</th></tr>" + res.sort.join + "</table>"
	 end
end
