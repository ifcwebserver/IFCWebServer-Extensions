class IFCGRIDAXIS
	def to_dae
		@axisCurve.toIfcObject 
		$ifcObjects[@axisCurve.delete("#").to_i].to_dae
	end
	
	def svg(scale=1,transformation="")
		res=""
		axis_obj = @axisCurve.to_obj 
		axis_obj.xy_min_max
		$font_size= 10 if $font_size == nil
		
		style="style=\"font-size:#$font_size;\""
		res += "<text " + style + " x=\"" + axis_obj.xy_array[0] + "\" y=\"" + axis_obj.xy_array[1] + "\">" + @axisTag.gsub("'","") + "</text>"
		res += "<text " + style + " x=\"" + axis_obj.xy_array[-2] + "\" y=\"" + axis_obj.xy_array[-1] + "\">" + @axisTag.gsub("'","") + "</text>"
		res += axis_obj.svg(scale,transformation)
		res
	end
end