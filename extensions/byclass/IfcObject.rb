require '/var/www/html/conf.rb'
require "sqlite3"

class IFCOBJECT	
  #SET OF IfcRelDefines FOR RelatedObjects;
  def isDefinedBy
    res= '<table width="100%" style="margin:5px" class="propertyset">'
    #out=IFCRELDEFINESBYPROPERTIES.where("o.relatedObjects.to_s.include?('#" + @line_id.to_s + "')","o.relatingPropertyDefinition")
    out=IFCRELDEFINESBYPROPERTIES.where("o.relatedObjects.gsub(' ','').include?('#" + @line_id.to_s + ")') or o.relatedObjects.gsub(' ','').include?('#" + @line_id.to_s + ",')","o.relatingPropertyDefinition")
    out.join.toIfcObject.each { |k,v| 			
    if v.respond_to?('property_details')
      res += v.property_details
    else
     # res += "|" + $ifcClassesNames[v.class.to_s] + "|" + v.globalId + "|" + v.name + "|</br>"
    end
     }		
    out=IFCRELDEFINESBYTYPE.where("o.relatedObjects.to_s.include?('#" + @line_id.to_s + "')","o.relatingType")
    out.join.toIfcObject.each { |k,v| 
    if v.respond_to?('property_details')
       res += v.property_details 			
    else
     #  res += "|" + $ifcClassesNames[v.class.to_s] + "|" + v.globalId + "|" + v.name + "|</br>"
    end			
    }	
    res.gsub("<table width='100%' class='propertyset'>","").gsub("<table  class='propertyset'>","").gsub("</table>","") + "</table>"
     
  end	
  
  def db_pset
    #doc:<div class='documentaion' >return a table with all object properties saved in the BIM-DB</div>
    db = SQLite3::Database.new $cache_folder + "/" + $username + "/" + $ifc_file_name  + "/" +  $ifc_file_name.sub(".ifc","_Pset.sqlite")
    res="<table><tr><th>Pset</th><th>Property</th><th>Value</th></tr>"
    db.execute( "select PsetName, propertyname, propertyvalue from properties where step_id = #{self.line_id} order by pSetName,propertyname") do |row|
       res +=  "<tr><td>" +  row[0] + "</td><td>" +  row[1] +  "</td><td>" +  row[2] + "</td><tr>"
    end
    res += "</table>"
  end
  
  def db_select_pset(propertyname, psetName= "")
    #doc:<div class='documentaion' >return a table with one or more object proeprties saved in the BIM-DB. The user can add filter by PSetName</div>
    db = SQLite3::Database.new $cache_folder + "/" + $username + "/" + $ifc_file_name  + "/" +  $ifc_file_name.sub(".ifc","_Pset.sqlite")
    res="<table><tr><th>Property</th><th>Value</th></tr>"
      if psetName != ""
          if propertyname.kind_of?(Array)
            sql = "select propertyname, propertyvalue from properties where  PsetName = '#{psetName}' and propertyname in ( #{propertyname.sub("[","").sub("]","")} )  and step_id = #{self.line_id}"
          else
            sql = "select propertyname, propertyvalue from properties where  PsetName = '#{psetName}' and propertyname = '#{propertyname}' and step_id = #{self.line_id}"
          end
      else
          if propertyname.kind_of?(Array)
            sql = "select propertyname, propertyvalue from properties where propertyname in ( #{propertyname.sub("[","").sub("]","")} )  and step_id = #{self.line_id}"
          else
            sql = "select propertyname, propertyvalue from properties where propertyname = '#{propertyname}' and step_id = #{self.line_id}"
          end
      end
      
      db.execute(sql) do |row|
       res +=  "<tr><td>" +  row[0] + "</td><td>" +  row[1] + "</td><tr>"
    end
    res += "</table>"
  end
  
  def db_get_property(propertyname, psetName= "")
       #doc:<div class='documentaion' >return the value of object property.</div>
      db = SQLite3::Database.new $cache_folder + "/" + $username + "/" + $ifc_file_name  + "/" +  $ifc_file_name.sub(".ifc","_Pset.sqlite")
      res = ""
     if psetName != ""
          if propertyname.kind_of?(Array)
            sql = "select propertyvalue from properties where  PsetName = '#{psetName}' and propertyname in ( #{propertyname.sub("[","").sub("]","")} )  and step_id = #{self.line_id}"
          else
            sql = "select propertyvalue from properties where  PsetName = '#{psetName}' and propertyname = '#{propertyname}' and step_id = #{self.line_id}"
          end
     else
           if propertyname.kind_of?(Array)
             sql = "select propertyvalue from properties where propertyname in ( #{propertyname.sub("[","").sub("]","")} )  and step_id = #{self.line_id}"
           else
             sql = "select propertyvalue from properties where propertyname = '#{propertyname}' and step_id = #{self.line_id}"
           end
     end   
     db.execute(sql) do |row|
       res +=    row[0].to_s
     end
    res
  end
  
end
