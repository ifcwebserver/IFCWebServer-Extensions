class IFCPROPERTYSINGLEVALUE
	def initialize1(args=[])		
		if IFCPROPERTYSINGLEVALUE::VAR_NUM != args.size 
		#	@nominalValue=args[-1] 	
		#	line=$hash['#' + @line_id.to_s]
		#	ifcClassName,lineData=  line.scan(/(\IFC[A-Z]*)|(\(.+?\;)/)
		#	new_args = lineData.join[1..lineData.join.size-3].scan(/('[^']+'|\$)/).flatten
		#	@name=new_args[0]
		#	@description=new_args[1]
		#	@unit= new_args[3]
		#ex: #100057 = IFCPROPERTYSINGLEVALUE('NominalLength', 'Nominal, typically the ..dimension.', IFCLENGTHMEASURE(300.), #100056);
		#
		

		end
		
		class_name = args[2].to_s.scan(/\IFC[A-Z0-9]*/)[0]
		args[2]  = args[2].sub(class_name,"").sub(")","").sub("(","") if class_name != nil
		super
	end
	
		
	def to_row		 		 
		 @unit.sub!("$","")
		 @description.sub!("$","")
		 @description =encode_string(@description) if @description != ""
		 unit_obj=@unit.to_obj
		 @unit = unit_obj.prefix.sub("$","").gsub(".","") + "" + unit_obj.name.gsub(".","") if  unit_obj!= nil and unit_obj.respond_to?('prefix')		 
		"\n\t<tr>\n\t<td width='50%'><b>" +  encode_string(@name.strip[1..-2]) + "</b></td><td width='50%'>" +  encode_string(@nominalValue.to_s) + "</td><td></td>\n\t</tr>"
		#<td>" +  @unit + "</td><td>" + @description + "</td>
	end
	

	def valid_name(obj=self)
		attName=encode_string(obj.name).gsub(" ","_").gsub("-","_").gsub(".","_").gsub("/","_")
		attName = attName.gsub("__","_")
		attName = attName.gsub("__","_")
		attName = attName.gsub("\\","")
		attName = attName.gsub("/","_")
		attName = attName.gsub("(","_")
		attName = attName.gsub(")","_")
		attName = attName.gsub(".","")
		attName = attName.gsub("\\X\\B2","2")
		attName = attName.gsub("\\X\\B3","3")
		attName = attName.gsub("[","_")
		attName = attName.gsub("]","_")
	end
	
	def valid_value(obj=self)
		encode_string(obj.nominalValue.to_s)
	end

	
	def to_xml(obj=self)
		attName = valid_name(obj)		
		attValue=valid_value(obj)		
		"<" + attName + " id='" + obj.line_id.to_s  + "'>" + attValue + "</" + attName + ">\n"			
	end
	
	def to_xml_full(obj=self)			
		"<IFCPROPERTYSINGLEVALUE>\n\t<id>" + obj.line_id.to_s + "</id>\n\t<name>" + obj.name.gsub("'","") + 
		"</name>\n\t<value>" + obj.nominalValue.to_s + "</value>\n</IFCPROPERTYSINGLEVALUE>"
	end			
	

	#def to_csv(obj=self)
	#	obj.line_id.to_s + "\t" + obj.name + "\t" + obj.nominalValue.to_s + "\n"
	#end
	
	def attach_to_obj(obj)
		obj.instance_variable_set("@ext_" + encode_string(@name[1..-2]).uncapitalize.gsub(" ","_").gsub(".","_").gsub("-","_").gsub("/","_"), encode_string(@nominalValue)  )
	end
end