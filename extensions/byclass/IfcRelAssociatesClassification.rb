class IFCRELASSOCIATESCLASSIFICATION
	def initialize1(args=[])
		if IFCRELASSOCIATESCLASSIFICATION::VAR_NUM != args.size 
				@relatingClassification=args[-1] 
				@relatedObjects=args[-2] 				
				parse
		end
		attach_to_obj
	end
	
	def attach_to_obj
		@relatedObjects.to_s.toIfcObject.each {|k,v|		
		relatingClassificationObj = @relatingClassification.to_s.to_obj
		relatingClassificationObj.attach_to_obj(v)	if relatingClassificationObj.respond_to?("attach_to_obj")		
		}	
	end
#private
	def parse
		line=$hash['#' + @line_id.to_s]
		ifcClassName,lineData=  line.scan(/(\IFC[A-Z0-9]*)|(\(.+?\;)/)
		new_args = lineData.join[1..lineData.join.size-3].scan(/('[^']+'|\$)/).flatten
		@name= new_args[1]	
		@description	= new_args[2]	
	end
end 