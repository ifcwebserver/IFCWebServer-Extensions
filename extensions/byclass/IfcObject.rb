class IFCOBJECT	
  #SET OF IfcRelDefines FOR RelatedObjects;
  def isDefinedBy
    res= "<table  class='propertyset'>"
    out=IFCRELDEFINESBYPROPERTIES.where("o.relatedObjects.to_s.include?('#" + @line_id.to_s + "')","o.relatingPropertyDefinition")
    out.join.toIfcObject.each { |k,v| 			
    if v.respond_to?('property_details')
      res += v.property_details.sub("<table class='propertyset'>","").sub("</table>","")
    else
      res += "|" + $ifcClassesNames[v.class.to_s] + "|" + v.globalId + "|" + v.name + "|</br>"
    end
     }		
    out=IFCRELDEFINESBYTYPE.where("o.relatedObjects.to_s.include?('#" + @line_id.to_s + "')","o.relatingType")
    out.join.toIfcObject.each { |k,v| 
    if v.respond_to?('property_details')
       res += v.property_details.sub("<table class='propertyset'>","").sub("</table>","") 			
     else
       res += "|" + $ifcClassesNames[v.class.to_s] + "|" + v.globalId + "|" + v.name + "|</br>"
    end			
    }		
    res + "</table>"
  end	
end