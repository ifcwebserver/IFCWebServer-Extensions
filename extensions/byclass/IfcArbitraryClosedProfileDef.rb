class IFCARBITRARYCLOSEDPROFILEDEF
	def area
		@outerCurve.toIfcObject
		o=$ifcObjects[@outerCurve.delete("#").to_i]
		if  o != nil and o.respond_to?("area")
			o.area
		else
			$log["<br>Line:" + __LINE__.to_s ]= "  " +  o.class.to_s + ".area() is not yet supported"
		end
	end

	def diameter
		@outerCurve.toIfcObject
		o=$ifcObjects[@outerCurve.delete("#").to_i]
		if o != nil and o.respond_to?("diameter")
			o.perimeter.to_f/(2 * 3.14152)
		end	
	end

	def perimeter
		@outerCurve.toIfcObject
		o=$ifcObjects[@outerCurve.delete("#").to_i]
		if o != nil and o.respond_to?("perimeter")
			o.perimeter
		end
	end

	def to_svg
		@outerCurve.toIfcObject
		o=$ifcObjects[@outerCurve.delete("#").to_i]
		if  o.respond_to?('to_svg')
			o.to_svg
		else
			$log["<br>Line:" + __LINE__.to_s ]= "  " +  o.class.to_s + ".to_svg() is not yet supported"
		end
	end
	
	def svg(scale=1)
	@outerCurve.toIfcObject
	o=$ifcObjects[@outerCurve.delete("#").to_i]
		if  o.respond_to?('svg')
			o.svg(scale)
		else
			$log["<br>Line:" + __LINE__.to_s ]= "  " +  o.class.to_s + ".to_svg() is not yet supported"
		end	
	end

	def xyz_array
		@outerCurve.toIfcObject
		o=$ifcObjects[@outerCurve.delete("#").to_i]
		if o.respond_to?('xyz_array')			
			o.xyz_array.join
		else			
			$log["<br>" + __FILE__.to_s + " Line:" + __LINE__.to_s ]= "  " +  o.class.to_s + ".xyz_array is not yet supported"
		end
	end
	
	def xy_array
		curveObj=@outerCurve.to_obj
		curveObj.xy_array.join if curveObj.respond_to?('xy_array')
	end
end