class IFCCLASSIFICATIONREFERENCE
		def initialize1(args=[])		
			if IFCCLASSIFICATIONREFERENCE::VAR_NUM != args.size 
				@referencedSource=args[-1] 
				parse
			end
		end
#Location	 : 	OPTIONAL IfcLabel;
	#IFC2x3 ItemReference	 : 	OPTIONAL IfcIdentifier; 
# OR
	#IFC2x4 Identification	 : 	OPTIONAL IfcIdentifier;
#Name	ItemReference : 	OPTIONAL IfcLabel;
#ReferencedSource	 : 	OPTIONAL IfcClassificationReferenceSelect;
#New in IFC2x4: Description	 : 	OPTIONAL IfcText;
	def attach_to_obj(obj)
		obj.instance_variable_set("@ext_ClassificationReference_Location",@location.to_s)					if @location.to_s != "" and @location.to_s != "$"
		obj.instance_variable_set("@ext_ClassificationReference_Identification",@identification.to_s)		if @identification.to_s != "" and @identification.to_s != "$"
		obj.instance_variable_set("@ext_ClassificationReference_ItemReference",@itemReference.to_s)			if @itemReference.to_s != "" and @itemReference.to_s != "$"
		obj.instance_variable_set("@ext_ClassificationReference_Name",@name.to_s)							if @name.to_s != "" and @name.to_s != "$"
		obj.instance_variable_set("@ext_ClassificationReference_ReferencedSource",@referencedSource.to_s)	if @referencedSource.to_s != "" and @referencedSource.to_s != "$"
		obj.instance_variable_set("@ext_ClassificationReference_Description",@description.to_s)				if @description.to_s != "" and @description.to_s != "$"
	end
	
	
#private
	def parse
		line=$hash['#' + @line_id.to_s]
		ifcClassName,lineData=  line.scan(/(\IFC[A-Z0-9]*)|(\(.+?\;)/)
		new_args = lineData.join[1..lineData.join.size-3].scan(/('[^']+'|\$)/).flatten
		@location=new_args[0]
		@itemReference=new_args[1]
		@name= new_args[2]
		
	end
end