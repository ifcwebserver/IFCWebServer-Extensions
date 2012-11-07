class IFCCOMPOSITECURVESEGMENT
	def xyz_array
		o=@parentCurve.toIfcObject.values[0]
		if o.respond_to?('xyz_array')
			o.xyz_array
		else
			$log["<br>" + __FILE__.to_s + " Line:" + __LINE__.to_s ]= "  " +   o.class.to_s + " xyz_array is not yet supported"
		end
	end
	
	#Inverse
	#SET [1:?] OF IfcCompositeCurve FOR Segments;
	def usingCurves
	end
end