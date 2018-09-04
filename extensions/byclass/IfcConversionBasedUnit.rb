class IFCCONVERSIONBASEDUNIT
attr_accessor :unitExponent
	def initialize1(args)
		@unitExponent =@dimensions.to_s.to_obj.unitExponent	if @dimensions.to_s.to_obj != nil and @dimensions.to_s.to_obj.respond_to?('unitExponent')
	end	
end