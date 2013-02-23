class IFCASYMMETRICISHAPEPROFILEDEF
	def to_svg
		SVG.to_svg(self)
	end
	
	def svg(scale=1,transformation="")	
	    style = "style=\"fill:gray;stroke:blue;stroke-width:1\" "
		style=$svg_style if $svg_style != nil
		res = "<polyline points=\"" 
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
		res += "\" " + style + " />"
		return res
	end
end