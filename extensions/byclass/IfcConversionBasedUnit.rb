class IFCCONVERSIONBASEDUNIT
attr_accessor :unitExponent
	def initialize1(args)
		@unitExponent =@dimensions.to_s.to_obj.unitExponent		
	end	
end