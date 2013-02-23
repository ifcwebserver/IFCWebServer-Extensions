class IFCARBITRARYPROFILEDEFWITHVOIDS
	def area
		@outerCurve.toIfcObject
		o=$ifcObjects[@outerCurve.delete("#").to_i]
		if  o != nil and o.respond_to?("area")
			totalArea = o.area
			voidsArea=0
		    @innerCurves.toIfcObject { |k,v|
		    voidsArea += v.area if v.respond_to?('area')
		    }
		    totalArea - voidsArea
		else
			$log["<br>Line:" + __LINE__.to_s ]= "  " +  o.class.to_s + ".area() is not yet supported"
		end
	end	
	
	def xyz_array
		@outerCurve.to_s.toIfcObject
		o=$ifcObjects[@outerCurve.delete("#").to_i]
		if o.respond_to?('xyz_array')			
			o.xyz_array
		else			
			$log["<br>" + __FILE__.to_s + " Line:" + __LINE__.to_s ]= "  " +  o.class.to_s + ".xyz_array is not yet supported"
		end
	end
end