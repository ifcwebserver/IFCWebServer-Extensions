class IFCRELAGGREGATES
  def initialize1(args)	
    attach_to_obj if $loading_relation == true
    $depend_on={} if $depend_on == nil
    $depend_on[@relatingObject.to_s] ="" if $depend_on[@relatingObject.to_s]== nil
    $depend_on[@relatingObject.to_s] += "#" + @line_id.to_s 
    super
  end

  def relatingobjectInfo
	relatingObject = @relatingObject.to_s.to_obj 
        relatingObject.class.to_s + ": " + relatingObject.name + " ID(" + relatingObject.line_id.to_s + ")"
  end 

  def relatedObjectsInfo
	res= ""
	@relatedObjects.toIfcObject.each { |id,o|
        res += o.class.to_s + ":" + o.name +  " ID(" + o.line_id.to_s + ") <br>"
        }
        res
  end 
end