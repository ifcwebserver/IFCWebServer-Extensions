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
end