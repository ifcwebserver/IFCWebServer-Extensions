class IFCCIRCLEHOLLOWPROFILEDEF
	def area
		@radius = @radius.to_f
		((Math::PI*@radius*@radius-(Math::PI*(@radius-@wallThickness.to_f )*(@radius-@wallThickness.to_f )))*$ifcUnit["Length"]*$ifcUnit["Length"]).to_f.round_to(3)
	end
	def perimeter
		(2*Math::PI*@radius.to_f*$ifcUnit["Length"]).to_s
	end	
	
	def xyz_array	
	end	
	
	def to_svg
		SVG.to_svg(self)
	end
	
	def svg(scale=1,transformation="")
	    style = " style=\"fill:white;stroke:gray;stroke-width:" + @wallThickness.to_s + "\" "
		style=$svg_style if $svg_style != nil
	    if transformation == ""
			transformation = " transform=\" scale(" + scale.to_s + "," + scale.to_s + ")\""
		end	
		res = "<g " + transformation + " >"		
		res += "<circle cx=\"" +  (@radius.to_f*1.05).to_s + "\" cy=\"" + (@radius.to_f*1.05).to_s + "\" r=\"" + @radius.to_f.to_s + "\""
		res += " " + style + " /></g>"						
		return res
	end
end