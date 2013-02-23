class IFCRELAGGREGATES
  def initialize1(args)	
    attach_to_obj if $loading_relation == true
    $depend_on={} if $depend_on == nil
    $depend_on[@relatingObject.to_s] ="" if $depend_on[@relatingObject.to_s]== nil
    $depend_on[@relatingObject.to_s] += "#" + @line_id.to_s 
	super
  end	
  
  def attach_to_obj
    super		
  end	
end