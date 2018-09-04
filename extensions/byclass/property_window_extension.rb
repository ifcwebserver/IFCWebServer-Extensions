$class_atts={}
IFC.subclasses.each { |c|
next if c::ABSTRACT
numOfParameters= ( c.nonInverseAttributes + c.inverseAttributes + c.derivAttributes ).sub("|","").split("|").size
parameters_array=[]
(c.nonInverseAttributes + c.inverseAttributes +  c.derivAttributes ).sub("|","").split("|").each_with_index { |att,index|
  next if att == nil or att == ""
  parameters_array << att.to_s if not parameters_array.include?(att.to_s)    
}
$class_atts[c.to_s]=parameters_array
}

class IFC
  def format_property(obj,att)
    res= ""
    row=[]
    if att == "isDefinedBy"
       res += "<tr><td colspan=2>" + obj.instance_eval(att) + "</td></tr>"
    else
      row << att
      result= obj.instance_eval(att)
	if result.class == String and result.include?('#')
	  row << result.to_obj.as_link 
          res += HTML.arr_to_row_html(row)
        elsif result.class == Array and result.size== 0 
        elsif result.class == Array and result.size > 10
	elsif result.class == Hash
        elsif result == nil
	else
	  row << result.to_s
	  res += HTML.arr_to_row_html(row)
	end
    end
    res
  end

  def property_table(obj=self) 
    res=""	 
    res += "<table class='propertyset'><tr><th>Property</th><th>Value</th></tr>"
    res += "<tr><td>STEP ID</th><td>#" + obj.line_id.to_s + "</td></tr>"
    $class_atts[obj.class.to_s].each { |att|
      if obj.respond_to?(att)
	begin	
         res += format_property(obj,att)
        rescue Exception => e
          #puts "</br><b>Error</b>:" + e.message + "</br>"
	  #puts e.backtrace.inspect + "<hr>"
	 end
      end
    }
    res += "</table>"
   end
end