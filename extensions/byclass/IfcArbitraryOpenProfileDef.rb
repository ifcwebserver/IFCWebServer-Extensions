class IFCARBITRARYOPENPROFILEDEF
	def perimeter
		curveObj=@curve.to_obj
		curveObj.perimeter if curveObj.respond_to?('perimeter')
	end
	
	def xyz_array
		curveObj=@curve.to_obj
		curveObj.xyz_array if curveObj.respond_to?('xyz_array')
	end
	
	def xy_array
		curveObj=@curve.to_obj
		curveObj.xy_array if curveObj.respond_to?('xy_array')
	end
	
	def to_svg
		curveObj=@curve.to_obj
		curveObj.to_svg if curveObj.respond_to?('to_svg')
	end	
end