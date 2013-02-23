#OverallWidth	 : 	IfcPositiveLengthMeasure;
#OverallDepth	 : 	IfcPositiveLengthMeasure;
#WebThickness	 : 	IfcPositiveLengthMeasure;
#FlangeThickness	 : 	IfcPositiveLengthMeasure;
#FilletRadius	 : 	OPTIONAL IfcPositiveLengthMeasure;

class IFCISHAPEPROFILEDEF
	def area
	 	2*@flangeThickness.to_f*@overallWidth.to_f + @webThickness.to_f*(@overallDepth.to_f-2*@flangeThickness.to_f)
	end
	
	def perimeter
		4*@overallWidth.to_f + 2*@overallDepth.to_f - 2*@webThickness.to_f 
	end
	
	def xyz_array
	end
	
	def xy_array
	end
	
	def to_svg
		SVG.to_svg(self)
	end
	
	def svg(scale=1,transformation="")
	style = " style=\"fill:gray;stroke:blue;stroke-width:1\" "
	style=$svg_style if $svg_style != nil
	if	transformation== ""
	  transformation= " transform=\" scale(" + scale.to_s + "," + scale.to_s + ")\""
	end
	res = "<g " + transformation+ " >"
	res += "<polyline points=\"" 
	res += "0,0 " + @overallWidth.to_f.to_s + ",0 " + @overallWidth.to_f.to_s + "," + @flangeThickness.to_f.to_s + " "
	res += (0.5 *(@webThickness.to_f + @overallWidth.to_f)).to_s + "," + @flangeThickness.to_f.to_s + " "
	res += (0.5 *(@webThickness.to_f + @overallWidth.to_f)).to_s + "," + (@overallDepth.to_f - @flangeThickness.to_f).to_s + " "
	res += @overallWidth.to_f.to_s									  + "," + (@overallDepth.to_f - @flangeThickness.to_f).to_s + " "
	res += @overallWidth.to_f.to_s									  + "," + @overallDepth.to_f.to_s + " "
	res += "0,"												  +  @overallDepth.to_f.to_s + " "
	res += "0,"												  + (@overallDepth.to_f - @flangeThickness.to_f).to_s + " " 
	res += (0.5*@overallWidth.to_f - 0.5*@webThickness.to_f).to_s + "," + (@overallDepth.to_f - @flangeThickness.to_f).to_s + " "
	res += (0.5*@overallWidth.to_f - 0.5*@webThickness.to_f).to_s + "," + @flangeThickness.to_f.to_s + " "
	res += "0," + @flangeThickness.to_f.to_s + " 0,0"
	res += "\" " + style + " /></g>"
	return res
	end
end