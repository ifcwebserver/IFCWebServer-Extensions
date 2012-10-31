class IFCTRIMMEDCURVE
	def xyz_array
	[]
	end
	
	def initialize1(args=[])		
		#	if IFCTRIMMEDCURVE::VAR_NUM != args.size 
		parse
		#	end			
	end
#private
	def parse
		@basisCurve=""
		@trim1=""
		@trim2=""	
		@senseAgreement=""
		@masterRepresentation=""		
		line=$hash['#' + @line_id.to_s]
		ifcClassName,lineData=  line.scan(/(\IFC[A-Z0-9]*)|(\(.+?\;)/)
		new_args = lineData.join.gsub("(","").gsub(")","").gsub(";","").gsub("IFCPARAMETERVALUE","").scan(/([^,]*\([^\)]*\)|[^,]+)/).flatten
		@basisCurve=new_args[0] 
		if new_args.size == 5 then
			@trim1=new_args[1]
			#new_args[2]
			@trim2=new_args[2]
		else
			@trim1=new_args[1]
			#new_args[2]
			@trim2=new_args[3]
		end
		#new_args[4].to_s].join#.to_f.round_to(3)	
		@senseAgreement=new_args[-2]
		@masterRepresentation=new_args[-1]		
	end
end