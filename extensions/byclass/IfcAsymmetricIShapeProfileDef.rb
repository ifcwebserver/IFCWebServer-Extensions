class IFCASYMMETRICISHAPEPROFILEDEF
	def area
	end
	
	def perimeter
	end
	
	def xyz_array
	end
	
	def xy_array
	end
	
	def to_svg
		SVG.to_svg(self)
	end
	
	def svg
		res = "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\""
		res += " width=\"" + @overallWidth.to_f.to_s + "\" "
		res += " height=\"" +  @overallDepth.to_f.to_s + "\" "
		res +=" >"
		res += "<polyline points=\"" 
		res += "0,0 " + @overallWidth.to_f.to_s + ",0 " + @overallWidth.to_f.to_s + "," + @flangeThickness.to_f.to_s + " "
		res += (0.5 *(@webThickness.to_f + @overallWidth.to_f)).to_s + "," + @flangeThickness.to_f.to_s + " "
		res += (0.5 *(@webThickness.to_f + @overallWidth.to_f)).to_s + "," + (@overallDepth.to_f - @flangeThickness.to_f).to_s + " "
		res += @topFlangeWidth.to_f.to_s									  + "," + (@overallDepth.to_f - @flangeThickness.to_f).to_s + " "
		res += @topFlangeWidth.to_f.to_s									  + "," + @overallDepth.to_f.to_s + " "
		res += "0,"												  +  @overallDepth.to_f.to_s + " "
		res += "0,"												  + (@overallDepth.to_f - @flangeThickness.to_f).to_s + " " 
		res += (0.5*@topFlangeWidth.to_f - 0.5*@webThickness.to_f).to_s + "," + (@overallDepth.to_f - @flangeThickness.to_f).to_s + " "
		res += (0.5*@topFlangeWidth.to_f - 0.5*@webThickness.to_f).to_s + "," + @flangeThickness.to_f.to_s + " "
		res += "0," + @flangeThickness.to_f.to_s + " 0,0"
		res += "\" style=\"fill:gray;stroke:blue;stroke-width:1\" /></svg>"
		return res
	end
end