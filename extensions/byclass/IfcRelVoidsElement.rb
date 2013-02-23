class IFCRELVOIDSELEMENT
  def initialize1(args=[])		
    $depend_on={} if $depend_on == nil
    $depend_on[@relatingBuildingElement.to_s] ="" if $depend_on[@relatingBuildingElement.to_s]== nil
    $depend_on[@relatingBuildingElement.to_s] += "#" + @line_id.to_s
  end
  
  def count()
	@relatedOpeningElement.to_s.split("#").size-1
  end
  
  def add(instance_id)
    @relatedOpeningElement =  "#" + instance_id.to_s
  end
  
  def count_by_class
    classes={}
	@relatedOpeningElement.toIfcObject.each { |k,o|
	classes[o.class.to_s] == nil ? classes[o.class.to_s] = 1 :classes[o.class.to_s] += 1}
	classes
  end 
end