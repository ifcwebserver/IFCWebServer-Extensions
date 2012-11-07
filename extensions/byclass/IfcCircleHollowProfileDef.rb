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
	
	def svg(scale=1)
		scale=(@radius.to_f/200) if @radius.to_f > 200	
		scale= 100 if @radius.to_f < 1	
		scale= 1000 if @radius.to_f < 0.1			
		res = "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\""
		res += " width=\"" +  (2.1*scale*@radius.to_f).to_s + "\" height=\"" + (2.1*scale*@radius.to_f).to_s + "\" >"
		res += "<g transform=\" scale(" + scale.to_s + "," + scale.to_s + ")\">"
		res += "<circle cx=\"" +  (@radius.to_f*1.05).to_s + "\" cy=\"" + (@radius.to_f*1.05).to_s + "\" r=\"" + @radius.to_f.to_s + "\""
		res += " style=\"fill:white;stroke:gray;stroke-width:" + @wallThickness.to_s + "\" /></g></svg>"		
		res += " </br><font size=\"1\">"
		res += " scale=" + scale.to_s  + "</br>" if scale != 1
		res += "R=" + @radius.to_s + "</font>"
		return res
	end
end