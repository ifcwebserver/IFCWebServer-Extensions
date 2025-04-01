class IFCCOLOURRGB
	def to_RGB
		@red.to_f   > 1 ? red_ratio=	@red.to_f/255 : red_ratio= @red
		@green.to_f > 1 ? green_ratio=@green.to_f/255 : red_ratio= @green
		@blue.to_f  > 1 ? blue_ratio= @blue.to_f/255 : red_ratio= @blue
		return  @red.to_f.round_to(4).to_s + "," + @green.to_f.round_to(4).to_s  + "," + @blue.to_f.round_to(4).to_s 	
	end

	def to_RGB_HEX
		@red.to_f   > 1 ? red_ratio=	@red.to_f/255 : red_ratio= @red
		@green.to_f > 1 ? green_ratio=@green.to_f/255 : red_ratio= @green
		@blue.to_f  > 1 ? blue_ratio= @blue.to_f/255 : red_ratio= @blue
		return  "\#" + sprintf("%02x", @red.to_f*255).upcase  +  sprintf("%02x", @green.to_f*255).upcase + sprintf("%02x", @blue.to_f*255).upcase	
	end
	
	def to_html_div
		"<div class='color_rgb' style=\"background-color:" + to_RGB_HEX + "\">&nbsp;</div>"
	end

	def to_html_div_details
		"<div class='color_rgb' style=\"background-color:" + to_RGB_HEX + "\">RGB(&nbsp;" + (255 *@red.to_f).to_i.to_s + ",&nbsp;" + (255 * @green.to_f).to_i.to_s  + "," + (255 * @blue.to_f).to_i.to_s + "&nbsp;) &nbsp;HTML:#" + sprintf("%02x", @red.to_f*255).upcase +  sprintf("%02x", @green.to_f*255).upcase +  sprintf("%02x", @blue.to_f*255).upcase + "</div>"
	end

end