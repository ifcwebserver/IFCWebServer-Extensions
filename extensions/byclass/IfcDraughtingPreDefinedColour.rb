class IFCDRAUGHTINGPREDEFINEDCOLOUR
	def to_html_div
		"<div style=\"background-color:" + @name.gsub("'","") + "\">&nbsp;</div>"
	end	
	
	def to_RGB
		return  "0,0,0"	if @name.gsub("'","").downcase == "black"
		return  "1,0,0"	if @name.gsub("'","").downcase == "red"
		return  "0,1,0"	if @name.gsub("'","").downcase == "green"
		return  "0,0,1"	if @name.gsub("'","").downcase == "blue"
		return  "1,1,0"	if @name.gsub("'","").downcase == "yellow"
		return  "1,0,1"	if @name.gsub("'","").downcase == "magenta"
		return  "0,1,1"	if @name.gsub("'","").downcase == "cyan"
		return  "1,1,1"	if @name.gsub("'","").downcase == "white"
	end

	def to_RGB_HEX
		return  "#000000"	if @name.gsub("'","").downcase == "black"
		return  "#FF0000"	if @name.gsub("'","").downcase == "red"
		return  "#00FF00"	if @name.gsub("'","").downcase == "green"
		return  "#0000FF"	if @name.gsub("'","").downcase == "blue"
		return  "#FFFF00"	if @name.gsub("'","").downcase == "yellow"
		return  "#FF00FF"	if @name.gsub("'","").downcase == "magenta"
		return  "#00FFFF"	if @name.gsub("'","").downcase == "cyan"
		return  "#FFFFFF"	if @name.gsub("'","").downcase == "white"	
		""
	end
end