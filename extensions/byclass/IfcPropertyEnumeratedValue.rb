class IFCPROPERTYENUMERATEDVALUE
	def initialize1(args=[])		
		if IFCPROPERTYENUMERATEDVALUE::VAR_NUM != args.size 
			@enumerationReference = args[-1]		
			line=$hash['#' + @line_id.to_s]
			ifcClassName,lineData=  line.scan(/(\IFC[A-Z0-9]*)|(\(.+?\;)/)
			new_args = lineData.join[1..lineData.join.size-3].scan(/('[^']+'|\$)/).flatten
			@name=new_args[0]
			@description=new_args[1]			
			@enumerationValues=new_args[2..-1].join(',')		
		end
	end
	
	def to_row			 
		 @description.sub!("$","") 
		 if @enumerationReference != "$" and @enumerationReference != ""
			selected= HTML.select_box_html(fix_it(@name),@enumerationReference.to_obj.enumerationValues.gsub("'","").split(",")[0..-1],[@enumerationValues.to_s.gsub("'","")],false,"","")
			#selected= fix_it(@enumerationValues.to_s)
		 else
			selected= fix_it(@enumerationValues.to_s)
		 end
		 "<tr><th>" + fix_it(@name) + "</th><td>" + selected + "</td><td></td><td>" +@description + "</td></tr>"
	end
	
	def to_xml(obj)
		"<PROPERTY>\n\t<name>" + fix_it(obj.name) + "</name>\n\t<value>" + fix_it(obj.enumerationValues.to_s) + "</value>\n</PROPERTY>\n"		
	end
	
	def attach_to_obj(obj)	
		obj.instance_variable_set("@ext_" + fix_it(@name[1..-2]).uncapitalize.gsub(" ","_").gsub(".","_").gsub("-","_"), fix_it(@enumerationValues)  )
	end
end
