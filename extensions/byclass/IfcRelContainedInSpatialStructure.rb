class IFCRELCONTAINEDINSPATIALSTRUCTURE
  def initialize1(args=[])			
   # attach_to_obj if $loading_relation == true    
	$depend_on={} if $depend_on == nil
    $depend_on[@relatingStructure.to_s] ="" if $depend_on[@relatingStructure.to_s]== nil
    $depend_on[@relatingStructure.to_s] += "#" + @line_id.to_s
	super
  end
  
  def attach_to_obj
	@relatedElements.to_s.toIfcObject.each {|k,v|		
	relatingStructure_Obj = @relatingStructure.to_s.to_obj	
	containedInStructure= {}
	containedInStructure['globalId'] =relatingStructure_Obj.globalId
	containedInStructure['name'] =relatingStructure_Obj.name
	containedInStructure['class'] =relatingStructure_Obj.class.to_s		
	v.instance_variable_set("@containedInStructure" , containedInStructure )	if relatingStructure_Obj != nil		 
	#v.instance_variable_set("@containedInStructure" , relatingStructure_Obj.globalId  )	if relatingStructure_Obj != nil		 
	#v.instance_variable_set("@containedInStructureName" , relatingStructure_Obj.name  )	if relatingStructure_Obj != nil		 
	#v.instance_variable_set("@containedInStructureClass" , $ifcClassesNames[relatingStructure_Obj.class.to_s]  )	if relatingStructure_Obj != nil		 
	}	
  end
  
  def count()
	@relatedElements.to_s.split("#").size-1
  end
  
  def add(instance_id)
    @relatedElements += "," + "#" + instance_id.to_s
  end
  
  def count_by_class
    classes={}
	@relatedElements.toIfcObject.each { |k,o|
	classes[o.class.to_s] == nil ? classes[o.class.to_s] = 1 :classes[o.class.to_s] += 1}
	classes
  end 
end