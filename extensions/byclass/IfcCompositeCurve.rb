class IFCCOMPOSITECURVE
	def xyz_array		
		xyz=[]
		@segments.toIfcObject.each { |v,o|
		if o.respond_to?('xyz_array')
			xyz << 	o.xyz_array
		else
			$log["<br>" + __FILE__.to_s + " Line:" + __LINE__.to_s ]= "  " +  o.class.to_s + ".xyz_array() is not yet supported"	
		end	
		}		
		return xyz
	end
end	