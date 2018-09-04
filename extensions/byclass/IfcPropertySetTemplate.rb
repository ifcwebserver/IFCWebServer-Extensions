class IFCPROPERTYSETTEMPLATE 
	 def propertyTemplates_html
		res= []
		hasPropertyTemplates.toIfcObject.each { |k,o|		
		primaryMeasureType=""
		primaryMeasureType = o.primaryMeasureType.to_s.gsub("'","") if o.respond_to?("primaryMeasureType") and o.primaryMeasureType != nil
		row ="<tr><td><a href='#' title='" + primaryMeasureType + "'>" + o.name.to_s.gsub("'","") + "</a></td>"
		row += "<td>"		
		if  primaryMeasureType.to_s  == "IfcDate"
		row +="<input type='date' size=20 />" 
		elsif primaryMeasureType.to_s  == "IfcPositiveLengthMeasure"
		row +="<input type='text'  size=20 />" 
		elsif primaryMeasureType.to_s.index(" ") == 0
		row +="<input type='text' size=20 />"		
		else
		row +="<input type='text' size=20 />" # + primaryMeasureType.to_s 
		end
		row += "</td></tr>"
		res << row
		}
		"<form action=''><table><tr><th colspan='2' align='left'>" + "<a href='#' title='" + @description.gsub("'","_") + "'>" + @name.gsub("'","").sub("Qto_","").sub("Pset_","") + "</a></th></tr>" + res.sort.join + "<tr><td></td><td><input type='submit' value='Update' ></td></tr></table></form>"
	 end
	 
	 def propertyTemplates
	   res= []
	   hasPropertyTemplates.toIfcObject.each { |k,o|
	    res << o.name
	   }
	   res
	 end
end
