class IFCWINDOW 
	def area
		(@overallHeight.to_f*@overallWidth.to_f).round_to(3)
	end
	def initialize1(args)
		@overallHeight=@overallHeight.to_f.round_to(3)
		@overallWidth=@overallWidth.to_f.round_to(3)		
	end
end