class IFCDIRECTION
attr_accessor :dir1 , :dir2 , :dir3 , :size
	def initialize(line_id, args=[])
		super
		@directionRatios=args[0]
		return if @directionRatios == nil
		arr=@directionRatios.delete("(").delete(")").split(",")
		@dir1=arr[0].to_f
		@dir2=arr[1].to_f		
		if arr[1] != nil
			@dir3=arr[1].to_f
			@size=3
		else
			@dir3=nil
			@size=2
		end	
	end
end