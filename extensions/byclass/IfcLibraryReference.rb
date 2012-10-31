class IFCLIBRARYREFERENCE
	def initialize1(args=[])		
			#if IFCPROPERTYENUMERATION::VAR_NUM != args.size 
			#	@unit=args[-1] 
			#	parse
			#end
			@description  = fix_it(@description.to_s)
			@name  = fix_it(@name.to_s)
	end
#private
	def parse
	#TODO this class has different attributes in IFC2, IFC3, IFC4 schemas
		line=$hash['#' + @line_id.to_s]
		ifcClassName,lineData=  line.scan(/(\IFC[A-Z0-9]*)|(\(.+?\;)/)
		new_args = lineData.join[1..lineData.join.size-3].scan(/('[^']+'|\$)/).flatten
		
	end
end