class IFCARBITRARYPROFILEDEFWITHVOIDS
	def area
	totalArea= super.area
	voidsArea=0
	@innerCurves.toIfcObject { |k,v|
	voidsArea += v.area if v.respond_to?('area')
	}
	totalArea - voidsArea
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