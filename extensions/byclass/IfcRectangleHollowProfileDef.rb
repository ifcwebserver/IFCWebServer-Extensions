class IFCRECTANGLEHOLLOWPROFILEDEF
	def area
	end#((@xDim.to_f * @yDim.to_f - (@xDim.to_f-@wallThickness.to_f)*(@yDim.to_f-@wallThickness.to_f))*$ifcUnit["Length"]*$ifcUnit["Length"]).to_f.round_to(3)
	
	def perimeter
		((3.141592653589*@roundingRadius.to_f + 2*(@xDim.to_f - 2*@roundingRadius.to_f) + 2*(@yDim.to_f - 2*@roundingRadius.to_f))*$ifcUnit["Length"]).to_s
	end
	
	def xyz_array
	end
	
	def xy_array
	end
	
	def to_svg
	end
	
	def svg
	end
end