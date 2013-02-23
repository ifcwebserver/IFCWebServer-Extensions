class IFCELLIPSEPROFILEDEF
	def area
		Math::PI*@semiAxis1.to_f*@semiAxis2.to_f
	end
	
	def perimeter
		2*Math::PI*Math.sqrt((@semiAxis1.to_f*@semiAxis1.to_f + @semiAxis2.to_f*@semiAxis2.to_f)/2)
	end
end