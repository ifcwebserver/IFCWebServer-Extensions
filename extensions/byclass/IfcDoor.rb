class IFCDOOR	
	def initialize1(args)
		@overallHeight=@overallHeight.to_f.round_to(3)
		@overallWidth=@overallWidth.to_f.round_to(3)
        super		
	end
	
	def area
		(@overallHeight.to_f*@overallWidth.to_f).round_to(3)
	end
end