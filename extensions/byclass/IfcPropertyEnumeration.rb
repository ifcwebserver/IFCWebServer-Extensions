class IFCPROPERTYENUMERATION
attr_accessor :size , :enumerationValuesList
#Name	 : 	IfcLabel;
#EnumerationValues	 : 	LIST [1:?] OF UNIQUE IfcValue;
#Unit
	def initialize1(args=[])		
		if IFCPROPERTYENUMERATION::VAR_NUM != args.size 
			@unit=args[-1] 
			parse
		end
		@size =@enumerationValues.split(',').size
		@enumerationValuesList  = "<ol><li>" + @enumerationValues.split(',').join('<li>') + "</ol>"
	end
			
#private
	def parse
		line=$hash['#' + @line_id.to_s]
		ifcClassName,lineData=  line.scan(/(\IFC[A-Z0-9]*)|(\(.+?\;)/)
		new_args = lineData.join[1..lineData.join.size-3].scan(/('[^']+'|\$)/).flatten
		@name=new_args[0]
		@enumerationValues=new_args[1..-2].join(',')		
	end
	
	def size
	@enumerationValues.split(',').size
	end
end