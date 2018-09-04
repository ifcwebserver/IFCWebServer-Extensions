class IFCFILLAREASTYLE
  def validate_rules
	if @fillStyles == "$" or @fillStyles == ""
		puts "<div style='background-color:rgb(255, 230, 230);padding: 16px ;width:50%' >"
			puts "Missing Non-optional member:"
			puts self.class.to_s + "<br>"
			puts $hash["#" +@line_id.to_s]	
		puts "</div>"
	end
  end
  
  def fillStyles_colour
  colour=""
  @fillStyles.toIfcObject.each { |k,o|  
  colour = o.to_RGB_HEX if (o.class == IFCCOLOURRGB or o.class == IFCDRAUGHTINGPREDEFINEDCOLOUR) 
  }
  return colour
  end
  
end
